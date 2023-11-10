from urllib import request
from rest_framework import serializers
from urllib.parse import urlparse

from .models import CustomFiles, LifeStation, Location, LocationReference, Stolperstein, StolpersteinRelation, Textbox, Tour, TourLocation

class CustomFileModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomFiles
        fields = '__all__'

    # This is required to fix a problem where URLs were returned incorrectly (I don't know how this ever worked without this fix tbh)
    # Turns this -> https://res.cloudinary.com/dythpl8mo/video/upload/v1/public/https://res.cloudinary.com/dythpl8mo/video/upload/v1/public/videos/20231016/720p1Min_o3qmlm
    # into this -> https://res.cloudinary.com/dythpl8mo/video/upload/v1/public/videos/20231016/720p1Min_o3qmlm
    def to_representation(self, instance):
        data = super().to_representation(instance)
        data['photo'] = self.correct_url(data['photo'])
        data['audio'] = self.correct_url(data['audio'])
        data['video'] = self.correct_url(data['video'])
        return data
    
    def correct_url(self, url):
        if(url == None):
            return url
    
        public_index = url.find("/public/")
        if public_index != -1:
            edited_url = url[public_index + len("/public/"):]

        # Since this funny problem only happens when retrieving the url but this code is also used when saving the url
        # we need to check if the edited url is actually valid. This is so messed up
        # Obviously the best solution would be to find out why the url is so fucked when retrieving it but I can't be bothered right now
        if "https://" in edited_url:
            return edited_url
        
        return url
  
class LocationModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = Location
        fields = ('id', 'name', 'coordinates')
        extra_kwargs = {
            'coordinates': {
                'validators': []
            }
        }

class LocationReferenceModelSerializer(serializers.ModelSerializer):
    class Meta: 
        model = LocationReference
        exclude = ('responsible_users',)

class LifeStationModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = LifeStation
        fields = '__all__'

class StolpersteinMinInfoModelSerializer(serializers.ModelSerializer):
    name = serializers.CharField(max_length=100)
    location = LocationModelSerializer()
    class Meta:
        model = Stolperstein
        fields = ('name', 'location')

class StolpersteinRelationModelSerializer(serializers.ModelSerializer):
    related_stolperstein = StolpersteinMinInfoModelSerializer()

    class Meta:
        model = StolpersteinRelation
        fields = '__all__'

class TextboxModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = Textbox
        fields = '__all__'    

class StolpersteinModelSerializer(serializers.ModelSerializer):
    PERSECUTION_CHOICES = (
        ('JEWISH', 'jewish religion'),
        ('POLITICAL', 'political persecution'),
        ('HOMOSEXUAL', 'homosexual orientation'),
        ('OTHER', 'other'),
        ('UNKNOWN', 'unknown'),
    )

    id = serializers.IntegerField(read_only=True)
    name = serializers.CharField(required = True, max_length=100)
    location = LocationModelSerializer()
    files = CustomFileModelSerializer(required=False, many=False)
    placementdate = serializers.DateField(required=False, allow_null=True, default=None)
    birthdate = serializers.DateField(required=False, allow_null=True, default=None)
    deathdate = serializers.DateField(required=False, allow_null=True, default=None)
    birthplace = serializers.CharField(required=False, max_length=100, allow_blank=True)
    deathplace = serializers.CharField(required=False, max_length=100, allow_blank=True)
    reason_for_persecution = serializers.ChoiceField(
        choices=PERSECUTION_CHOICES, default='UNKNOWN')
    info_text = serializers.CharField(required=False, allow_blank=True)
    family_text = serializers.CharField(required=False, allow_blank=True)
    stolperstein_relations = StolpersteinRelationModelSerializer(required=False, many=True)
    life_stations = LifeStationModelSerializer(required=False, many=True)
    info_textboxes = TextboxModelSerializer(required=False, many=True)
    class Meta:
        model = Stolperstein
        fields = ['id', 'name', 'reason_for_persecution', 'location',
            'files', 'placementdate', 'birthdate', 'deathdate', 'birthplace', 'deathplace', 
            'birthdate', 'info_text', 'family_text', 'life_stations', 'stolperstein_relations', 'info_textboxes']


class TourSerializer(serializers.ModelSerializer):
    class Meta:
        model = Tour
        fields = '__all__'

class TourLocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = TourLocation
        fields = '__all__'


# Hyperlink Model Serializers

class LocationSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Location
        exclude = ('responsible_users',)

class LifeStationSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = LifeStation
        fields = '__all__'

class StolpersteinMinInfoSerializer(serializers.Serializer):
    name = serializers.CharField(max_length=100)
    location = LocationSerializer()

class StolpersteinRelationSerializer(serializers.HyperlinkedModelSerializer):
    related_stolperstein = StolpersteinMinInfoSerializer()
    
    class Meta:
        model = StolpersteinRelation
        fields = '__all__'
        extra_kwargs = {
            'id': {
                'validators': []
            }
        }

class FullStolpersteinRelationSerializer(serializers.HyperlinkedModelSerializer):
    
    class Meta:
        model = StolpersteinRelation
        fields = '__all__'

class StolpersteinSerializer(serializers.HyperlinkedModelSerializer):
    life_stations = LifeStationSerializer(required=False, many=True)
    stolperstein_relations = StolpersteinRelationSerializer(required=False, many=True)
    # stolperstein_files = CustomFileModelSerializer(required=False)
    class Meta:
        model = Stolperstein
        fields = '__all__'


