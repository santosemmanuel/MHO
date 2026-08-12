from django.template import loader
from django.shortcuts import render, redirect
from django.http import HttpResponse, JsonResponse
from django.views.decorators.http import require_http_methods
from django.contrib import messages
from animal_bite.models import PatientRecord
import json
from .pdf_fillers import fill_cf1, fill_cf2, fill_csf, fill_soa
from .pdf_utils import clean_files
from pathlib import Path
from django.conf import settings
import datetime
from datetime import date
from django.utils.timezone import localdate

today = localdate()
start_of_today = datetime.datetime.combine(today, datetime.time.min)
end_of_today = datetime.datetime.combine(today, datetime.time.max)

# Create your views here.

def _load_json(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        return json.load(f)


def calculate_age(dob_str):
    if not dob_str:
        return 0
    try:
        birth_date = datetime.datetime.strptime(dob_str, '%Y-%m-%d').date()
    except ValueError:
        return 0

    return (date.today() - birth_date).days // 365


def calculate_age_month_days(dob_str):
    if not dob_str:
        return ''
    try:
        birth_date = datetime.datetime.strptime(dob_str, '%Y-%m-%d').date()
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
        parsed = datetime.datetime.fromisoformat(value)
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
        today = date.today()
        data = _parse_form_data(request.POST)

        try:
            fill_cf1(data)
            fill_cf2(data)
            fill_csf(data)
            # fill_soa(data)

            pin = data['pin']
            membership = "Member"
            firstName = data['firstName']
            lastName = data['lastName']
            middleName = data['middleName']
            nameExt = data['nameExt']

            if data['patientIsMember'] == 'no':
                pin = data['dependent']['depPin']
                membership = "Dependent"
                firstName = data['dependent']['depFname']
                lastName = data['dependent']['depLname']
                middleName = data['dependent']['depMname']
                nameExt = data['dependent']['depExt']

            PatientRecord.objects.create(
                first_name=firstName,
                middle_name=middleName,
                last_name=lastName,
                name_ext=nameExt,
                barangay=data['barangay'],
                pin=pin,
                membership=membership,
                day_0=today
            )

        except Exception as e:
            messages.error(request, f'PDF generation error: {str(e)}')
            return redirect('/animal_bite/')

        request.session['animal_bite_patient_data'] = data
        messages.success(request, 'PDFs generated successfully. You may now view and download the files.')

        return redirect('/animal_bite/view_print/')
    except Exception as e:
        messages.error(request, f'Unexpected error: {str(e)}')
        return redirect('/animal_bite/')


def view_print(request):
    """
    View and download the generated PDFs with a Statement of Account tab.
    """
    patient = request.session.get('animal_bite_patient_data', {})
    # if not patient:
    #     messages.warning(request, 'No submission found. Please submit the form before viewing PDFs.')
    #     return redirect('/animal_bite/')

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

    # 1. Load JSON data (itemized_charges is a dict with top-level keys)
    raw_itemized = _load_json(settings.BASE_DIR / 'animal_bite' / 'static' / 'json' / 'itemized-charges.json')
    raw_fee_summary = _load_json(settings.BASE_DIR / 'animal_bite' / 'static' / 'json' / 'fee-summary.json')
    raw_prof_fees = _load_json(settings.BASE_DIR / 'animal_bite' / 'static' / 'json' / 'professional-fees.json')

    # 2. Calculate patient age cleanly
    dob = patient.get('depDob') if patient.get('dependent') else patient.get('dob', '')
    patient_age = calculate_age(dob)

    # 3. Determine the correct key for itemized charges
    if patient_age >= 60:
        charge_key = 'Senior'
    elif patient_age < 1:
        charge_key = 'Below1'
    elif 1 <= patient_age <= 5:
        charge_key = 'OneToFive'
    else:
        charge_key = 'Regular'

    # 4. Extract arrays safely without reassigning dict lookups in-place
    itemized_charges = raw_itemized.get(charge_key, raw_itemized.get('Regular', []))

    # Handle Fee Summary & Professional Fees (Senior vs Regular)
    summary_key = 'Senior' if patient_age >= 60 else 'Regular'
    fee_summary = raw_fee_summary.get(summary_key, raw_fee_summary)
    professional_fees = raw_prof_fees.get(summary_key, raw_prof_fees)

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

def claims_summary(request):
    """
    Display a summary of all animal bite claims/submissions
    """
    template = loader.get_template('animal_bite/claims_summary.html')
    
    # Retrieve current session data if available
    patient_data = request.session.get('animal_bite_patient_data', {})
    
    context = {
        'patient_data': patient_data,
        'has_submission': bool(patient_data),
    }
    
    return HttpResponse(template.render(context, request))

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


def get_patient_records(request): # Assuming this is your view function name
    """
    Retrieve all patient records from the database and return them as a JsonResponse.
    """
    date_str = request.GET.get('date')
    if date_str:
        try:
            date_obj = datetime.datetime.strptime(date_str, '%Y-%m-%d').date()
            records = PatientRecord.objects.filter(date_and_time__date=date_obj)
        except ValueError:
            records = PatientRecord.objects.none()
    else:
        records = PatientRecord.objects.all()

    record_list = []
    
    for record in records:
        record_list.append({
            'id': record.id,
            'first_name': record.first_name,
            'middle_name': record.middle_name,
            'last_name': record.last_name,
            'name_ext': record.name_ext,
            'barangay': record.barangay,
            'pin': record.pin,
            'membership': record.membership,
            'day_0': record.day_0.isoformat() if record.day_0 else None,
            'date_and_time': record.date_and_time.isoformat() if record.date_and_time else None,
        })
    
    # 2. Wrap the list in JsonResponse and set safe=False
    return JsonResponse(record_list, safe=False) 

def get_patient_noPIN(request):
    """
    Retrieve patient records without a PIN from the database and return them as a JsonResponse.
    """
    record_count = PatientRecord.objects.filter(pin__isnull=True) | PatientRecord.objects.filter(pin='000000000000') | PatientRecord.objects.filter(pin='').count()
    
    return JsonResponse({'count': record_count}, safe=False)

def get_dependent_patients(request):
    """
    Retrieve dependent patient records from the database and return them as a JsonResponse.
    """
    record_count = PatientRecord.objects.filter(membership='Dependent').count()

    return JsonResponse({'count': record_count}, safe=False)

def get_member_patients(request):
    """
    Retrieve member patient records from the database and return them as a JsonResponse.
    """
    record_count = PatientRecord.objects.filter(membership='Member').count()

    return JsonResponse({'count': record_count}, safe=False)


def patient_management(request):
    """
    Render the patient management page.
    """
    template = loader.get_template('animal_bite/patient_management.html')
    context = {}
    return HttpResponse(template.render(context, request))       