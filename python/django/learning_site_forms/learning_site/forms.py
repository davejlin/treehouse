from django import forms

class SuggestionForm(forms.Form):
    name = forms.CharField()
    email = forms.EmailField()
    suggestions = forms.CharField(widget=forms.Textarea)