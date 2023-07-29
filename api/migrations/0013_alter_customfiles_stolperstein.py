# Generated by Django 3.2 on 2022-01-16 12:35

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0012_alter_customfiles_stolperstein'),
    ]

    operations = [
        migrations.AlterField(
            model_name='customfiles',
            name='stolperstein',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='files', to='api.stolperstein'),
        ),
    ]
