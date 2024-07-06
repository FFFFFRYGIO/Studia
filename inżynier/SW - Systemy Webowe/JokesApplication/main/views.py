from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect
from django.http import HttpResponse
from .models import Joke
from .forms import JokeForm, GenerateJokesForm
from decouple import config
import requests


# Create your views here.


@login_required
def home(request):
    """ home page with list of users jokes """
    if request.method == "POST":
        Joke.objects.filter(owner=request.user).delete()
    jokes = Joke.objects.filter(owner=request.user)
    return render(request, "home.html", {"jokes_count": len(jokes), "jokes_list": jokes})


@login_required
def get_joke(request):
    """ get jokes page to get joke from api """
    url = config('JOKES_API_URL')
    response = requests.get(url)

    if request.method == 'POST':
        # if user is member of group PrivilegedUsers
        if not request.user.groups.filter(name='PrivilegedUsers').exists():
            return HttpResponse(f"<h1>Your are not a privileged user {request.user}, You can't add jokes</h1>")

        form = JokeForm(request.POST)
        if form.is_valid():
            new_joke = form.save(commit=False)
            new_joke.owner = request.user
            new_joke.save()
            return redirect("home")
    else:

        if response.status_code == 200:
            joke_data = response.json()
            new_joke = Joke()
            if joke_data['type'] == 'twopart':
                new_joke.joke = f'{joke_data["setup"]} {joke_data["delivery"]}'
            elif joke_data['type'] == 'single':
                new_joke.joke = joke_data["joke"]
            else:
                print(f'Some new type of joke: {joke_data["type"]}')

            new_joke.category = joke_data["category"]

            joke_form = JokeForm(initial={
                'joke': new_joke.joke,
                'category': new_joke.category,
            })

            return render(request, "get_joke.html", {"joke_form": joke_form})

        else:
            return HttpResponse(f"<h1>Failed to retrieve a joke. Status code: {response.status_code}</h1>")


@login_required
def generate_jokes(request):
    """ add jokes to file """
    if request.method == 'POST':
        form = GenerateJokesForm(request.POST)
        if form.is_valid():
            new_file_content = form.cleaned_data['jokes']

            if 'save_and_go_home' in request.POST:
                with open("jokes_source.txt", 'w', newline='') as file:
                    file.write(new_file_content.strip())
                return redirect("home")
            elif 'save_and_import' in request.POST:
                with open("jokes_source.txt", 'w', newline='') as file:
                    file.write(new_file_content.strip())
                    return redirect("import_jokes")
            elif 'dont_save_and_go_home' in request.POST:
                return redirect("home")

    else:
        with open("jokes_source.txt", 'r') as file:
            file_content = file.read()
            generate_jokes_form = GenerateJokesForm(initial={'jokes': file_content})
            return render(request, 'generate_jokes.html', {'generate_jokes_form': generate_jokes_form})


@login_required
def import_jokes(request):
    """ get jokes from file """
    if not request.user.groups.filter(name='PrivilegedUsers').exists():
        return HttpResponse(f"<h1>Your are not a privileged user {request.user}, You can't add jokes</h1>")
    else:
        with open("jokes_source.txt", 'r') as file:
            file_content = file.read().splitlines()
            for joke in file_content:
                new_joke = Joke(owner=request.user, joke=joke, category='authored')
                new_joke.save()
            return redirect("home")
