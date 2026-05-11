from django.template import loader
from django.shortcuts import render, redirect
from django.http import HttpResponse, JsonResponse
from django.views.decorators.http import require_http_methods
import json
from .pdf_fillers import fill_cf1, fill_cf2, fill_csf, fill_soa
from .pdf_utils import clean_files
from pathlib import Path
from django.conf import settings
from datetime import date, datetime, timedelta

# Create your views here.

def _load_json(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        return json.load(f)


def calculate_age(dob_str):
    if not dob_str:
        return 0
    try:
        birth_date = datetime.strptime(dob_str, '%Y-%m-%d').date()
    except ValueError:
        return 0

    return (date.today() - birth_date).days // 365


def calculate_age_month_days(dob_str):
    if not dob_str:
        return ''
    try:
        birth_date = datetime.strptime(dob_str, '%Y-%m-%d').date()
    except ValueError:
        return ''

    delta_days = (date.today() - birth_date).days
    years = delta_days // 365
    months = (delta_days % 365) // 30
    days = (delta_days % 365) % 30

    parts = []
    if years:
        parts.append(f"{years} yrs")
    if months:
        parts.append(f"{months} mos")
    if days:
        parts.append(f"{days} days")
    return ' '.join(parts) if parts else '0 days'


def format_datetime(value):
    if not value:
        return ''
    try:
        parsed = datetime.fromisoformat(value)
        return parsed.strftime('%b %d, %Y %H:%M')
    except ValueError:
        return str(value)


def _normalize_statement_info(statement):
    for section in ('left', 'right'):
        for item in statement.get('patientInfo', {}).get(section, []):
            value = item.get('value')
            if isinstance(value, list):
                item['value'] = '\n'.join(str(v) for v in value)
    return statement


def _parse_form_data(post):
    patient_is_member = post.get('patientIsMember', 'yes')
    signee = post.get('signee', 'member')

    dependent = None
    if patient_is_member == 'no':
        dependent = {
            'depPin': post.get('depPin', '').strip(),
            'depLname': post.get('depLname', '').strip(),
            'depFname': post.get('depFname', '').strip(),
            'depMname': post.get('depMname', '').strip(),
            'depDob': post.get('depDob', '').strip(),
            'depSex': post.get('depSex', '').strip(),
            'depExt': post.get('depExt', '').strip(),
            'relationship': post.get('relationship', '').strip(),
        }

    representative = None
    if signee == 'representative':
        representative = {
            'repName': post.get('repName', '').strip(),
            'repRelationship': post.get('repRelationship', '').strip(),
            'repReason': post.get('repReason', '').strip(),
        }

    return {
        'pin': post.get('pin', '').strip(),
        'lastName': post.get('lastName', '').strip(),
        'firstName': post.get('firstName', '').strip(),
        'nameExt': post.get('nameExt', '').strip(),
        'middleName': post.get('middleName', '').strip(),
        'dob': post.get('dob', '').strip(),
        'sex': post.get('sex', '').strip(),
        'street': post.get('street', '').strip(),
        'barangay': post.get('barangay', '').strip(),
        'municipality': post.get('municipality', '').strip(),
        'mobile': post.get('mobile', '').strip(),
        'email': post.get('email', '').strip(),
        'patientIsMember': patient_is_member,
        'dependent': dependent,
        'signee': signee,
        'representative': representative,
    }
def index(request):
    template = loader.get_template('animal_bite/index.html')
    context = {}
    return HttpResponse(template.render(context, request))


@require_http_methods(["POST"])
def submit_form(request):
    """
    Handle form submission and generate PDFs, then redirect to the PDF viewer page.
    """
    try:
        data = _parse_form_data(request.POST)

        try:
            fill_cf1(data)
            fill_cf2(data)
            fill_csf(data)
            # fill_soa(data)
        except Exception as e:
            return HttpResponse(f'PDF generation error: {str(e)}', status=500)

        request.session['animal_bite_patient_data'] = data

        return redirect('/animal_bite/view_print/')
    except Exception as e:
        return HttpResponse(f'Unexpected error: {str(e)}', status=500)


def view_print(request):
    """
    View and download the generated PDFs with a Statement of Account tab.
    """
    patient = request.session.get('animal_bite_patient_data', {})
    if not patient:
        return redirect('/animal_bite/')

    pdf_dir = settings.BASE_DIR / 'animal_bite' / 'static' / 'pdfs'
    pdf_file_order = [
        ('output_cf1.pdf', 'CF-1 Form'),
        ('output_cf2.pdf', 'CF-2 Form'),
        ('output_csf.pdf', 'CSF Form'),
    ]
    pdf_files = []
    if pdf_dir.exists():
        for filename, label in pdf_file_order:
            if (pdf_dir / filename).exists():
                pdf_files.append({'name': label, 'url': f'/static/pdfs/{filename}'})

    statement_path = settings.BASE_DIR / 'animal_bite' / 'static' / 'json' / 'statement-data.json'
    statement = _load_json(statement_path)

    if patient.get('dependent'):
        dependent = patient.get('dependent', {})
        patient_name = ' '.join(filter(None, [
            dependent.get('depFname'),
            dependent.get('depMname'),
            dependent.get('depLname'),
            dependent.get('depExt'),
        ]))
        patient_dob = calculate_age_month_days(dependent.get('depDob', ''))
    else:
        patient_name = ' '.join(filter(None, [
            patient.get('firstName'),
            patient.get('middleName'),
            patient.get('lastName'),
            patient.get('nameExt'),
        ]))
        patient_dob = calculate_age_month_days(patient.get('dob', ''))

    patient_address = ' '.join(filter(None, [
        patient.get('barangay'),
        f"{patient.get('municipality', '')}, Leyte" if patient.get('municipality') else '',
    ]))

    statement['patientInfo']['left'][0]['value'] = patient_name
    statement['patientInfo']['left'][1]['value'] = patient_address
    statement['patientInfo']['right'][0]['value'] = patient_dob
    statement['patientInfo']['right'][1]['value'] = format_datetime(patient.get('datetimeAdmitted', ''))
    statement['patientInfo']['right'][2]['value'] = format_datetime(patient.get('datetimeDischarged', ''))
    statement = _normalize_statement_info(statement)

    fee_summary = _load_json(settings.BASE_DIR / 'animal_bite' / 'static' / 'json' / 'fee-summary.json')
    professional_fees = _load_json(settings.BASE_DIR / 'animal_bite' / 'static' / 'json' / 'professional-fees.json')
    itemized_charges = _load_json(settings.BASE_DIR / 'animal_bite' / 'static' / 'json' / 'itemized-charges.json')

    patient_age = calculate_age(patient.get('dob', ''))
    if patient_age >= 60:
        fee_summary = fee_summary.get('Senior', fee_summary)
        professional_fees = professional_fees.get('Senior', professional_fees)
        itemized_charges = itemized_charges.get('Senior', itemized_charges)
    else:
        fee_summary = fee_summary.get('Regular', fee_summary)
        professional_fees = professional_fees.get('Regular', professional_fees)

        if patient_age < 1:
            itemized_charges = itemized_charges.get('Below1', itemized_charges)
        elif 1 <= patient_age <= 5:
            itemized_charges = itemized_charges.get('OneToFive', itemized_charges)
        else:
            itemized_charges = itemized_charges.get('Regular', itemized_charges)

    today_str = date.today().strftime('%b %d, %Y')
    for item_date in itemized_charges:
        item_date['date'] = today_str

   

    return render(request, 'animal_bite/viewPrintPDF.html', {
        'pdf_files': pdf_files,
        'pdf_files_json': json.dumps(pdf_files),
        'header': statement['header'],
        'patient_info': statement['patientInfo'],
        'fee_summary': fee_summary,
        'professional_fees': professional_fees,
        'itemized_charges': itemized_charges,
       
        'philhealth_amount': 5850.00,
        "total_amount": sum(
        to_number(x.get("amount"))
        for x in fee_summary
    ),

    "total_discount": sum(
        to_number(x.get("discount"))
        for x in fee_summary
    ),

    "total_other_funding": sum(
        to_number(x.get("otherFunding"))
        for x in fee_summary
    ),

    "total_balance": sum(
        to_number(x.get("balance"))
        for x in fee_summary
    ),

    "professional_total": sum(
        to_number(x.get("balance"))
        for x in professional_fees
    ),

    "itemized_total": sum(
        to_number(x.get("amount"))
        for x in itemized_charges
    ),
    })

def to_number(value):
    if value in [None, "", "-"]:
        return 0

    if isinstance(value, (int, float)):
        return value

    # remove commas from strings like "1,000.00"
    try:
        return float(str(value).replace(",", ""))
    except ValueError:
        return 0

def download_pdf(request, filename):
    """
    Download a specific PDF file
    """
    pdf_dir = settings.BASE_DIR / "animal_bite" / "static" / "pdfs"
    file_path = pdf_dir / filename
    
    # Security check: prevent directory traversal
    if not filename.endswith('.pdf') or not file_path.exists():
        return HttpResponse('File not found', status=404)
    
    try:
        with open(file_path, 'rb') as pdf_file:
            response = HttpResponse(pdf_file.read(), content_type='application/pdf')
            response['Content-Disposition'] = f'attachment; filename="{filename}"'
            return response
    except Exception as e:
        return HttpResponse(f'Error downloading file: {str(e)}', status=500)

