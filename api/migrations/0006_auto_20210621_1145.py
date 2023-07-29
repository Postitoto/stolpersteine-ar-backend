# Generated by Django 3.2 on 2021-06-21 11:45

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0005_location_responsible_users'),
    ]

    operations = [
        migrations.AlterField(
            model_name='order',
            name='position',
            field=models.IntegerField(),
        ),
        migrations.AlterUniqueTogether(
            name='order',
            unique_together={('position', 'location')},
        ),
    ]
