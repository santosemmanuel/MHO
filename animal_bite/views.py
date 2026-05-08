from django.template import loader
from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.views.decorators.http import require_http_methods
from django.views.decorators.csrf import csrf_exempt
import json
from .pdf_fillers import fill_cf1, fill_cf2, fill_csf, fill_soa
from .pdf_utils import clean_files
from pathlib import Path
from django.conf import settings

# Create your views here.
def index(request):
    template = loader.get_template('animal_bite/index.html')
    context = {}
    return HttpResponse(template.render(context, request))


@require_http_methods(["POST"])
@csrf_exempt
def submit_form(request):
    """
    Handle form submission and generate PDFs
    """
    try:
        # Parse JSON data from request body
        data = json.loads(request.body)
        
        # Generate PDFs based on the form data
        try:
            fill_cf1(data)
            fill_cf2(data)
            fill_csf(data)
            # fill_soa(data)
        except Exception as e:
            return JsonResponse({
                'status': 'error',
                'message': f'PDF generation error: {str(e)}'
            }, status=500)

        pdf_dir = settings.BASE_DIR / "animal_bite" / "static" / "pdfs"
        pdf_files = []
        if pdf_dir.exists():
            pdf_files = sorted([f.name for f in pdf_dir.glob("*.pdf")])

        return JsonResponse({
            'status': 'success',
            'message': 'PDFs generated successfully',
            'pdf_files': pdf_files,
        })
    
    except json.JSONDecodeError:
        return JsonResponse({
            'status': 'error',
            'message': 'Invalid JSON data'
        }, status=400)
    except Exception as e:
        return JsonResponse({
            'status': 'error',
            'message': f'Unexpected error: {str(e)}'
        }, status=500)


def view_print(request):
    """
    View and download the generated PDFs
    """
    pdf_dir = settings.BASE_DIR / "animal_bite" / "static" / "pdfs"
    
    try:
        # List all PDF files in the directory
        pdf_files = []
        if pdf_dir.exists():
            pdf_files = [f.name for f in pdf_dir.glob("*.pdf")]
        
        context = {
            'pdf_files': pdf_files,
            'pdf_dir_url': '/static/pdfs/'
        }
        
        template = loader.get_template('animal_bite/view_print.html')
        return HttpResponse(template.render(context, request))
    
    except Exception as e:
        return HttpResponse(f'Error loading PDFs: {str(e)}', status=500)


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

