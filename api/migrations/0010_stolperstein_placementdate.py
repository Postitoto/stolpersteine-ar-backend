# Generated by Django 3.2 on 2023-11-06 15:39

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0009_auto_20231015_1855'),
    ]

    operations = [
        migrations.AddField(
            model_name='stolperstein',
            name='placementdate',
            field=models.DateField(blank=True, null=True),
        ),
    ]