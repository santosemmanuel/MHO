from django.shortcuts import render
from django.contrib.auth.decorators import user_passes_test
# Create your views here.

def is_family_planning_staff(user):
    return user.groups.filter(name='FamilyPlanningStaff').exists()

@user_passes_test(is_family_planning_staff)
def dashboard(request):
    return render(request, 'family_planning/dashboard.html')
