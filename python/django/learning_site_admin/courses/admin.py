from django.contrib import admin
from datetime import date

from . import models


def make_in_progress(modeladmin, request, queryset):
    queryset.update(status='i', published=False)

make_in_progress.short_description = 'Mark selected courses in progress'


def make_in_review(modeladmin, request, queryset):
    queryset.update(status='r', published=False)

make_in_review.short_description = 'Mark selected courses as in review'


def make_published(modeladmin, request, queryset):
    queryset.update(status='p', published=True)

make_published.short_description = 'Mark selected courses as published'


class TextInline(admin.StackedInline):
    model = models.Text


class QuizInline(admin.StackedInline):
    model = models.Quiz


class AnswerInline(admin.TabularInline):
    model = models.Answer


class YearListFilter(admin.SimpleListFilter):
    title = 'year created'
    parameter_name = 'year'

    def lookups(self, request, model_admin):
        return (
            ('2015', '2015'),
            ('2016', '2016')
        )

    def queryset(self, request, queryset):
        if self.value() == '2015':
            return queryset.filter(
                created_at__gte=date(2015, 1, 1),
                created_at__lte=date(2015, 12, 31)
            )

        if self.value() == '2016':
            return queryset.filter(
                created_at__gte=date(2016, 1, 1),
                created_at__lte=date(2016, 12, 31)
            )


class CourseAdmin(admin.ModelAdmin):
    inlines = [TextInline, QuizInline]
    search_fields = ['title', 'description']
    list_filter = ['created_at', 'published', YearListFilter]
    list_display = ['title', 'created_at', 'published', 'time_to_complete', 'status']
    list_editable = ['status']
    radio_fields = {'teacher': admin.HORIZONTAL}
    actions = [make_in_progress, make_in_review, make_published]

    class Media:
        js = ('js/vendor/markdown.js', 'js/preview.js')
        css = {
            'all': ('css/preview.css'),
        }

class QuestionAdmin(admin.ModelAdmin):
    inlines = [AnswerInline]
    search_fields = ['prompt']
    list_display = ['prompt', 'quiz', 'order']
    list_editable = ['quiz', 'order']


class QuizAdmin(admin.ModelAdmin):
    fields = ['course', 'title', 'description', 'order', 'total_questions']


class TextAdmin(admin.ModelAdmin):
    fieldsets = (
        (None, {
            'fields': ('course', 'title', 'order', 'description')
        }),
        ('Add content', {
            'fields': ('content',),
            'classes': ('collapse',)
        })
    )


admin.site.register(models.Course, CourseAdmin)
admin.site.register(models.Text, TextAdmin)
admin.site.register(models.Quiz, QuizAdmin)
admin.site.register(models.MultipleChoiceQuestion, QuestionAdmin)
admin.site.register(models.TrueFalseQuestion, QuestionAdmin)
admin.site.register(models.Answer)

admin.site.site_header = "Learning Site administration"