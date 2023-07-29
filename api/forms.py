from django import forms
from django.forms import modelformset_factory
from .models import LifeStation, StolpersteinRelation
from django.core.exceptions import ValidationError
from django.utils.translation import ugettext_lazy as _
import re


def clean_form_coordinates(data):
    '''
    Helper function to make sure all coordinates have same format
    '''
    # GPS coordinate regex with value range check
    # (https://stackoverflow.com/questions/3518504/regular-expression-for-matching-latitude-longitude-coordinates)
    regex = r"^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?),\s*[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$"
    if not re.search(regex, data):
        raise ValidationError(_("Invalid Coordinate String"))
    # Remove spaces from coordinate string
    data = data.replace(" ", "")
    return data


class AddStolperstein(forms.Form):
    PERSECUTION_CHOICES = (
        ('UNKNOWN', 'unknown'),
        ('JEWISH', 'jewish religion'),
        ('POLITICAL', 'political persecution'),
        ('HOMOSEXUAL', 'homosexual orientation'),
        ('OTHER', 'other'),
    )
    name = forms.CharField(
        max_length=100,
        help_text="The name of the person this Stolperstein is dedicated to")
    photos = forms.ImageField(required=False)
    birthdate = forms.DateField(required=False)
    deathdate = forms.DateField(required=False)
    birthplace = forms.CharField(max_length=100, required=False)
    deathplace = forms.CharField(max_length=100, required=False)
    reason_for_persecution = forms.ChoiceField(
        choices=PERSECUTION_CHOICES)
    info_text = forms.CharField(widget=forms.Textarea, required=False)
    family_text = forms.CharField(widget=forms.Textarea, required=False)

    def clean_photos(self):
        data = self.cleaned_data['photos']
        return data


class AddLocation(forms.Form):
    coordinates = forms.CharField(
        max_length=38,
        help_text="The coordinates of the Stolperstein Location")
    name = forms.CharField(
        max_length=100,
        help_text="Name to be associated with location (optional)",
        required=False
    )

    # Validate coordinates
    def clean_coordinates(self):
        data = self.cleaned_data['coordinates']
        return clean_form_coordinates(data)


class AddLifeStation(forms.ModelForm):
    class Meta:
        model = LifeStation
        exclude = ('stolperstein', )

    def clearn_coordinates(self):
        data = self.cleaned_data['coordinates']
        return clean_form_coordinates(data)


LifeStationFormSet = modelformset_factory(
    LifeStation, exclude = ('stolperstein', ), extra=1
)


class AddStolpersteinRelation(forms.ModelForm):
    class Meta:
        model = StolpersteinRelation
        exclude = ('stolperstein',)


StolpersteinRelationFormSet = modelformset_factory(
    StolpersteinRelation, exclude=('stolperstein',), extra=1
)