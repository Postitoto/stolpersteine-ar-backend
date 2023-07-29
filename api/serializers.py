from urllib import request
from rest_framework import serializers

from .models import CustomFiles, LifeStation, Location, LocationReference, Stolperstein, StolpersteinRelation, Textbox

class CustomFileModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomFiles
        fields = '__all__'

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
            'files', 'birthdate', 'deathdate', 'birthplace', 'deathplace', 
            'birthdate', 'info_text', 'family_text', 'life_stations', 'stolperstein_relations', 'info_textboxes']

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


