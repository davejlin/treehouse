from django.contrib import admin

from .models import Course, Text


class StepInline(admin.StackedInline):
    model = Text

    
class CourseAdmin(admin.ModelAdmin):
    inlines = [StepInline,]

admin.site.register(Course, CourseAdmin)
admin.site.register(Text)