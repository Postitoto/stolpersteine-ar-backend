# Generated by Django 3.2 on 2023-08-11 14:11

import cloudinary_storage.storage
from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Location',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('coordinates', models.CharField(max_length=38, unique=True)),
                ('name', models.CharField(blank=True, default=None, max_length=100, null=True)),
                ('responsible_users', models.ManyToManyField(to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Stolperstein',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('birthdate', models.DateField(blank=True, null=True)),
                ('deathdate', models.DateField(blank=True, null=True)),
                ('birthplace', models.CharField(blank=True, max_length=100, null=True)),
                ('deathplace', models.CharField(blank=True, max_length=100, null=True)),
                ('reason_for_persecution', models.CharField(choices=[('JEWISH', 'jewish religion'), ('POLITICAL', 'political persecution'), ('HOMOSEXUAL', 'homosexual orientation'), ('OTHER', 'other'), ('UNKNOWN', 'unknown')], default='UNKNOWN', max_length=10)),
                ('info_text', models.TextField(blank=True, null=True)),
                ('family_text', models.TextField(blank=True, null=True)),
                ('location', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='stolpersteine', to='api.location')),
            ],
            options={
                'ordering': ['location', 'order__position'],
                'unique_together': {('name', 'location')},
            },
        ),
        migrations.CreateModel(
            name='Textbox',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=100)),
                ('content', models.TextField()),
                ('stolperstein', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='info_textboxes', to='api.stolperstein')),
            ],
        ),
        migrations.CreateModel(
            name='StolpersteinRelation',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('type', models.CharField(choices=[('FAMILY', 'family member'), ('WORK', 'work colleague'), ('FRIEND', 'friend'), ('NEIGHBOUR', 'neighbour'), ('COMMUNITY', 'community'), ('OTHER', 'other')], default='OTHER', max_length=10)),
                ('text', models.TextField(blank=True, null=True)),
                ('related_stolperstein', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='api.stolperstein')),
                ('stolperstein', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='stolperstein_relations', to='api.stolperstein')),
            ],
        ),
        migrations.CreateModel(
            name='LocationReference',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('coordinates', models.CharField(max_length=38)),
                ('name', models.CharField(blank=True, default=None, max_length=100, null=True)),
                ('test', models.CharField(blank=True, max_length=100, null=True)),
                ('responsible_users', models.ManyToManyField(to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='LifeStation',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('coordinates', models.CharField(max_length=38)),
                ('name', models.CharField(max_length=100)),
                ('text', models.TextField(blank=True)),
                ('stolperstein', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='life_stations', to='api.stolperstein')),
            ],
        ),
        migrations.CreateModel(
            name='CustomFiles',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('photoName', models.CharField(blank=True, default=None, max_length=100, null=True)),
                ('photo', models.ImageField(null=True, upload_to='photos/%Y/%m/%d/')),
                ('audioName', models.CharField(blank=True, default=None, max_length=100, null=True)),
                ('audio', models.FileField(null=True, storage=cloudinary_storage.storage.VideoMediaCloudinaryStorage(), upload_to='audios/%Y/%m/%d/')),
                ('stolperstein', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='files', to='api.stolperstein')),
            ],
        ),
        migrations.CreateModel(
            name='Order',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('position', models.IntegerField()),
                ('location', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='order', to='api.location')),
                ('stolperstein', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='order', to='api.stolperstein')),
            ],
            options={
                'unique_together': {('position', 'location')},
            },
        ),
    ]
