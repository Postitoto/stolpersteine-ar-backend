# Generated by Django 3.2 on 2022-03-18 14:47

import cloudinary_storage.storage
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0018_alter_customfiles_audio'),
    ]

    operations = [
        migrations.AlterField(
            model_name='customfiles',
            name='audio',
            field=models.FileField(null=True, storage=cloudinary_storage.storage.VideoMediaCloudinaryStorage(), upload_to='audios/%Y/%m/%d/'),
        ),
    ]