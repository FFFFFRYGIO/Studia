from django.urls import path, include
from register.views import register
from . import views

urlpatterns = [
    path("home/", views.home, name="home"),
    path("get_joke/", views.get_joke, name="get_joke"),
    path("generate_jokes/", views.generate_jokes, name="generate_jokes"),
    path("import_jokes/", views.import_jokes, name="import_jokes"),
    path("register/", register, name="register"),
    path("", include("django.contrib.auth.urls")),
]
