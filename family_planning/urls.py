from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='family_planning'),
    path('submit_form/', views.submit_form, name='submit_form'),
    path('view_print/', views.view_print, name='view_print'),
]