from django.shortcuts import redirect
from django.contrib.auth.decorators import login_required

@login_required
def dispatch_user(request):
    if request.user.groups.filter(name='AnimalBiteStaff').exists():
        return redirect('animal_bite:dashboard')
    elif request.user.groups.filter(name='FamilyPlanningStaff').exists():
        return redirect('family_planning:dashboard')
    return redirect('login')