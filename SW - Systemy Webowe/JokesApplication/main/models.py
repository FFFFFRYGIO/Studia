from django.db import models
from register.models import User

# Create your models here.


class Joke(models.Model):
    owner = models.ForeignKey(User, on_delete=models.CASCADE)
    joke = models.CharField(max_length=500)
    category = models.CharField(max_length=100)
    mark = models.IntegerField(null=True)
