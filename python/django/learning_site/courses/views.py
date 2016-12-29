from django.http import HttpResponse
from django.shortcuts import render

from .models import Course

# Create your views here.
def course_list(request):
    course_list = ""
    for course in Course.objects.all():
        course_list += "<p>"+str(course)+"</p>"
    return HttpResponse(course_list)