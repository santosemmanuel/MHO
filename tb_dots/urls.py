from django.urls import path
from . import views

app_name = 'tb_dots'

urlpatterns = [
    path('', views.index, name='tb_dots'),
]