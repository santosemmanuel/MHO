from django.urls import path
from . import views

app_name = 'dental'

urlpatterns = [
    path('', views.index, name='dashboard'),
    path('submit_form/', views.submit_form, name='submit_form'),
    path('view_print/', views.view_print, name='view_print'),
]