# Generated by Django 3.2 on 2022-03-18 11:49

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0017_textbox'),
    ]

    operations = [
        migrations.AlterField(
            model_name='customfiles',
            name='audio',
            field=models.FileField(null=True, upload_to='audios/%Y/%m/%d/'),
        ),
    ]