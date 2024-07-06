from django import forms
from .models import Joke


class JokeForm(forms.ModelForm):
    MARK_CHOICES = (
        ("5", "5: Very good"),
        ("4", "4: Good"),
        ("3", "3: Average"),
        ("2", "2: Bad"),
        ("1", "1: Very bad"),
    )

    mark = forms.ChoiceField(
        choices=MARK_CHOICES,
        widget=forms.RadioSelect(),
        label="Mark",
    )

    joke = forms.CharField(
        widget=forms.Textarea(attrs={'rows': 4, 'cols': 40}),
        label="Joke"
    )

    class Meta:
        model = Joke
        exclude = ['owner']


class GenerateJokesForm(forms.Form):
    jokes = forms.CharField(
        widget=forms.Textarea(attrs={'rows': 20, 'cols': 40}),
        label="Jokes"
    )
