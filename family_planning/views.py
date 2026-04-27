from django.template import loader
from django.shortcuts import render
from django.http import HttpResponse
# Create your views here.
def index(request):
    template = loader.get_template('family_planning/index.html')
    context = {}
    return HttpResponse(template.render(context, request))