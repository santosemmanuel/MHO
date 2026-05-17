from django.urls import path
from . import views

app_name = 'animal_bite'

urlpatterns = [
    path('', views.index, name='animal_bite'),
    path('dashboard/', views.index, name='dashboard'),
    path('submit_form/', views.submit_form, name='submit_form'),
    path('view_print/', views.view_print, name='view_print'),
    path('download/<str:filename>/', views.download_pdf, name='download_pdf'),
    path('claims_summary/', views.claims_summary, name='claims_summary'),
]