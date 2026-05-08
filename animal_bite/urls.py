from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='animal_bite'),
    path('submit_form/', views.submit_form, name='submit_form'),
    path('view_print/', views.view_print, name='view_print'),
    path('download/<str:filename>/', views.download_pdf, name='download_pdf'),
]