# Generated by Django 4.2.7 on 2023-11-04 04:40

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('main', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='joke',
            name='mark',
            field=models.IntegerField(null=True),
        ),
    ]
