from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='family_planning`')
]