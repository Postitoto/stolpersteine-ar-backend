# Generated by Django 3.2 on 2023-10-15 14:52

import cloudinary_storage.storage
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0005_auto_20231014_1524'),
    ]

    operations = [
        migrations.AlterField(
            model_name='customfiles',
            name='audio',
            field=models.FileField(null=True, storage=cloudinary_storage.storage.VideoMediaCloudinaryStorage(), upload_to='audios/%Y%m%d/'),
        ),
        migrations.AlterField(
            model_name='customfiles',
            name='photo',
            field=models.ImageField(null=True, storage=cloudinary_storage.storage.VideoMediaCloudinaryStorage(), upload_to='photos/%Y%m%d/'),
        ),
    ]