from django.template import loader
from django.http import HttpResponse
from django.shortcuts import render

# Create your views here.
def index(request):
    template = loader.get_template('dental/index.html')
    context = {}
    return HttpResponse(template.render(context, request))