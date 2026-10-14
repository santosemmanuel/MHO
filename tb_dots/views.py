from django.template import loader
from django.shortcuts import render, redirect
from django.http import HttpResponse, JsonResponse
from django.views.decorators.http import require_http_methods
from django.contrib import messages
from animal_bite.models import PatientRecord
import json
# from .pdf_fillers import fill_cf1, fill_cf2, fill_csf, fill_soa
# from .pdf_utils import clean_files
from pathlib import Path
from django.conf import settings
import datetime
from datetime import date
from django.utils.timezone import localdate

today = localdate()
start_of_today = datetime.datetime.combine(today, datetime.time.min)
end_of_today = datetime.datetime.combine(today, datetime.time.max)

# Create your views here.

def index(request):
    template = loader.get_template('tb_dots/index.html')
    context = {}
    return HttpResponse(template.render(context, request))
