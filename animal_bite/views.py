from django.shortcuts import render
from django.contrib.auth.decorators import user_passes_test

# Create your views here.
def is_animal_bite_staff(user):
    return user.groups.filter(name='AnimalBiteStaff').exists()

@user_passes_test(is_animal_bite_staff)
def dashboard(request):
    return render(request, 'animal_bite/dashboard.html')