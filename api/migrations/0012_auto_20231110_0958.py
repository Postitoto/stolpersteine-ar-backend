# Generated by Django 3.2 on 2023-11-10 08:58

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0011_tour_tourlocation'),
    ]

    operations = [
        migrations.AddField(
            model_name='tour',
            name='locations',
            field=models.ManyToManyField(through='api.TourLocation', to='api.Location'),
        ),
        migrations.AddField(
            model_name='tour',
            name='name',
            field=models.CharField(default='New Tour', max_length=255),
        ),
    ]
