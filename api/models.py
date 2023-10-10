from django.contrib.auth.decorators import permission_required
from django.contrib.auth.models import User
from django.db import models
from cloudinary_storage.storage import VideoMediaCloudinaryStorage

from stolpersteine.settings import DEBUG

class Location(models.Model):
    coordinates = models.CharField(max_length=38, unique=True)
    name = models.CharField(max_length=100, null=True,
                            blank=True, default=None)
    responsible_users = models.ManyToManyField(User)


class LocationReference(models.Model):
    coordinates = models.CharField(max_length=38)
    name = models.CharField(max_length=100, null=True,
                            blank=True, default=None)
    responsible_users = models.ManyToManyField(User)


class Stolperstein(models.Model):
    PERSECUTION_CHOICES = (
        ('JEWISH', 'jewish religion'),
        ('POLITICAL', 'political persecution'),
        ('HOMOSEXUAL', 'homosexual orientation'),
        ('OTHER', 'other'),
        ('UNKNOWN', 'unknown'),
    )
    name = models.CharField(max_length=100)
    location = models.ForeignKey(
        Location, related_name="stolpersteine", on_delete=models.CASCADE)
    birthdate = models.DateField(null=True, blank=True)
    deathdate = models.DateField(null=True, blank=True)
    birthplace = models.CharField(max_length=100, null=True, blank=True)
    deathplace = models.CharField(max_length=100, null=True, blank=True)
    reason_for_persecution = models.CharField(
        choices=PERSECUTION_CHOICES, default='UNKNOWN', max_length=10)
    info_text = models.TextField(null=True, blank=True)
    family_text = models.TextField(null=True, blank=True)

    class Meta:
        unique_together = (("name", "location"))
        ordering = ['location', 'order__position']

    def __str__(self):
        return self.name


class CustomFiles(models.Model):
    stolperstein = models.OneToOneField(
        Stolperstein, related_name="files", on_delete=models.CASCADE)
    photoName = models.CharField(
        null=True, blank=True, default=None, max_length=100, db_column="photo_name")
    photo = models.ImageField(
        upload_to='photos/%Y/%m/%d/', null=True, blank=False)
    audioName = models.CharField(
        null=True, blank=True, default=None, max_length=100, db_column="audio_name")
    # REMOVE THE 'storage' PARAMETER IF YOU WANT TO SAVE THE FILE ON YOUR LOCAL HARDDRIVE
    # DONT FORGET TO RUN: python3 manage.py makemigrations AND python3 manage.py migrate EACH TIME YOU CHANGE THIS
    # ALSO SEE THE NOTE ON settings.py
    audio = models.FileField(upload_to='audios/%Y/%m/%d/', null=True,
                             blank=False, storage=VideoMediaCloudinaryStorage()
                            )
    videoName = models.CharField(
        null=True, blank=True, default=None, max_length=100, db_column="video_name")
    video = models.FileField(upload_to='videos/%Y/%m/%d/', null=True,
                             blank=False, storage=VideoMediaCloudinaryStorage()
                             )



class LifeStation(models.Model):
    stolperstein = models.ForeignKey(Stolperstein,
                                     related_name="life_stations", on_delete=models.CASCADE)
    coordinates = models.CharField(max_length=38)
    name = models.CharField(max_length=100)
    text = models.TextField(blank=True)


class Order(models.Model):
    location = models.ForeignKey(
        Location, related_name="order", on_delete=models.CASCADE)
    position = models.IntegerField()
    stolperstein = models.OneToOneField(
        Stolperstein, related_name="order", on_delete=models.CASCADE)

    class Meta:
        unique_together = (("position", "location"))


class StolpersteinRelation(models.Model):
    RELATION_CHOICES = (
        ('FAMILY', 'family member'),
        ('WORK', 'work colleague'),
        ('FRIEND', 'friend'),
        ('NEIGHBOUR', 'neighbour'),
        ('COMMUNITY', 'community'),
        ('OTHER', 'other'),
    )
    stolperstein = models.ForeignKey(
        Stolperstein, related_name="stolperstein_relations", on_delete=models.CASCADE)
    related_stolperstein = models.ForeignKey(
        Stolperstein, on_delete=models.CASCADE)
    type = models.CharField(
        max_length=10, choices=RELATION_CHOICES, default='OTHER')
    text = models.TextField(null=True, blank=True)


class Textbox(models.Model):
    stolperstein = models.ForeignKey(Stolperstein,
                                     related_name="info_textboxes", on_delete=models.CASCADE)
    title = models.CharField(max_length=100)
    content = models.TextField()
