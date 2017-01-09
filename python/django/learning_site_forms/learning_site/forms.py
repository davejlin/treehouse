from django import forms
from django.core import validators

class SuggestionForm(forms.Form):
    name = forms.CharField()
    email = forms.EmailField()
    suggestions = forms.CharField(widget=forms.Textarea)
    honeypot = forms.CharField(required=False,
                               widget=forms.HiddenInput,
                               label="Leave empty",
                               validators=[validators.MaxLengthValidator(0)]
                               )
