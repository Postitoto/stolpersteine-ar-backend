from django.http.response import HttpResponse, HttpResponseBadRequest, HttpResponseForbidden, HttpResponseNotFound
from django.http import JsonResponse
from django.shortcuts import render, redirect, get_object_or_404
from django.urls import reverse
from django.contrib.auth.decorators import login_required, permission_required
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from rest_framework import viewsets, status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.parsers import JSONParser
from rest_framework.response import Response
from django.conf import settings
from django.db.models.signals import post_save
from django.dispatch import receiver
from rest_framework.authtoken.models import Token
from .serializers import (
    CustomFileModelSerializer, LocationModelSerializer, StolpersteinModelSerializer, StolpersteinRelationSerializer, StolpersteinSerializer, TourSerializer, TourLocationSerializer, LocationSerializer, LifeStationSerializer, FullStolpersteinRelationSerializer)
from .models import CustomFiles, LifeStation, Stolperstein, Location, Order, StolpersteinRelation, Textbox, Tour, TourLocation
from .forms import AddStolperstein, AddLocation, LifeStationFormSet, StolpersteinRelationFormSet
import re
import json

# function that creates a new token for new users
@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)
# Administrative

class StolpersteinViewSet(
        viewsets.ModelViewSet, LoginRequiredMixin, UserPassesTestMixin):
    queryset = Stolperstein.objects.all()
    serializer_class = StolpersteinSerializer

    def test_func(self):
        return self.request.user.is_superuser


class LocationViewSet(
        viewsets.ModelViewSet, LoginRequiredMixin, UserPassesTestMixin):
    queryset = Location.objects.all().order_by('coordinates')
    serializer_class = LocationSerializer

    def test_func(self):
        return self.request.user.is_superuser


class LifeStationViewset(
        viewsets.ModelViewSet, LoginRequiredMixin, UserPassesTestMixin):
    queryset = LifeStation.objects.all().order_by('stolperstein')
    serializer_class = LifeStationSerializer

    def test_func(self):
        return self.request.user.is_superuser


class StolpersteinRelationViewset(
        viewsets.ModelViewSet, LoginRequiredMixin, UserPassesTestMixin):
    queryset = StolpersteinRelation.objects.all().order_by('stolperstein')
    serializer_class = StolpersteinRelationSerializer

    def test_func(self):
        return self.request.user.is_superuser


class FullStolpersteinRelationViewset(
        viewsets.ModelViewSet, LoginRequiredMixin, UserPassesTestMixin):
    queryset = StolpersteinRelation.objects.all().order_by('stolperstein')
    serializer_class = FullStolpersteinRelationSerializer

    def test_func(self):
        return self.request.user.is_superuser


# API for retrieving and modifying data, permissions required
@api_view(['GET'])
@login_required
@permission_required("api.view_location", raise_exception=True)
def all_locations(request):
    '''
    Returns all location entries as JSON
    '''
    locations = Location.objects.all()
    serializer = LocationModelSerializer(
        locations, many=True, context={'request': request})
    return Response(
        serializer.data
    )


@api_view(['GET'])
@login_required
@permission_required("api.view_stolperstein", raise_exception=True)
def stolpersteine_at(request, coords, format=None, **kwargs):
    '''
    Returns all stolperstein entries at given coordinates as JSON
    '''
    location = Location.objects.get(coordinates=coords)
    stolpersteine = Stolperstein.objects.filter(location=location).order_by('order__position')
    serializer = StolpersteinModelSerializer(stolpersteine, many=True, context={'request': request})
    return Response(
        serializer.data
    )

@api_view(['GET'])
@login_required
@permission_required("api.view_stolperstein", raise_exception=True)
def api_stolperstein_by_id(request, id):
    try: 
        stolperstein = Stolperstein.objects.get(id=id)
    except Stolperstein.DoesNotExist:
        return Response(data="Stolperstein with id "+id+ " does not exist", status=status.HTTP_400_BAD_REQUEST)
    serializer = StolpersteinModelSerializer(stolperstein, context={'request': request})
    return Response(serializer.data)

@api_view(['GET'])
@login_required
@permission_required("api.view_stolperstein", raise_exception=True)
def api_all_stolpersteine(request):
    stolpersteine = Stolperstein.objects.all()
    serializer = StolpersteinModelSerializer(stolpersteine, many=True, context={'request': request})
    return Response(
        serializer.data
    )

@api_view(['POST'])
@login_required
@permission_required("api.add_location", raise_exception=True)
def api_add_location(request): 
    location_data = JSONParser().parse(request)
    location_serializer = LocationModelSerializer(data=location_data)
    if location_serializer.is_valid():
        coords = location_serializer.data.get("coordinates")
        location = Location.objects.create(
            coordinates=coords,
            name=location_serializer.data.get("name")
        )
        location.responsible_users.add(request.user)
        return Response("Successfully created location with coordinates "+coords, status=status.HTTP_201_CREATED)  
    return Response("Location form invalid, please check your request", status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
@login_required
@permission_required("api.add_custom_files", raise_exception=True)
def api_add_stolperstein_assets(request, stolpersteinId):
    try:
        stolperstein = Stolperstein.objects.get(id=stolpersteinId)
        existingFiles = CustomFiles.objects.get(stolperstein=stolpersteinId)
    except Stolperstein.DoesNotExist:
            return Response("Stolperstein does not exist. Please make sure that the Stolperstein exists before uploading assets for it.", 
                            status=status.HTTP_400_BAD_REQUEST)
    except CustomFiles.DoesNotExist:
        existingFiles = None
    
    file_serializer = CustomFileModelSerializer(existingFiles, data=request.data)

    try:
        if file_serializer.is_valid():
            file_serializer.save()
            return Response("Successfully uploaded assets", status=status.HTTP_200_OK)
        else:
            return Response(file_serializer.errors, status=400)
    except Exception as e:
        return Response(f"An unexpected error occured while saving the files to Cloudinary. Please try again \n{e}",
                        status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['POST'])
@login_required
@permission_required("api.add_stolperstein", raise_exception=True)
def api_add_stolperstein(request, coords, format=None, **kwargs):
    # Check if coords is a valid location
    try: 
        location = Location.objects.get(coordinates=coords)
    except Location.DoesNotExist:
        return Response(data='requested location does not exist', 
            status=status.HTTP_400_BAD_REQUEST)
    if not is_authorized(request, location):
        return Response(data="No permission to modify the current location's content", 
            status=status.HTTP_403_FORBIDDEN)
    stolperstein_serializer = StolpersteinModelSerializer(data=request.data)
    if (stolperstein_serializer.is_valid()):
        stolperstein = None
        try: 
            stolperstein = Stolperstein.objects.get(id=stolperstein_serializer.initial_data.get("id")) 
            stolperstein.name=stolperstein_serializer.data.get("name")                 
            stolperstein.reason_for_persecution=stolperstein_serializer.data.get("reason_for_persecution")
            # Updating Location not supported at the moment!!! TODO
            stolperstein.placementdate=stolperstein_serializer.data.get("placementdate")
            stolperstein.birthdate=stolperstein_serializer.data.get("birthdate")
            stolperstein.deathdate=stolperstein_serializer.data.get("deathdate")
            stolperstein.birthplace=stolperstein_serializer.data.get("birthplace")
            stolperstein.deathplace=stolperstein_serializer.data.get("deathplace")
            stolperstein.info_text=stolperstein_serializer.data.get("info_text")
            stolperstein.family_text=stolperstein_serializer.data.get("family_text")
            stolperstein.save()
        except Stolperstein.DoesNotExist:
            stolperstein = Stolperstein.objects.create(
                    name=stolperstein_serializer.data.get("name"),
                    reason_for_persecution=stolperstein_serializer.data.get("reason_for_persecution"),
                    location=location,
                    placementdate=stolperstein_serializer.data.get("placementdate"),
                    birthdate=stolperstein_serializer.data.get("birthdate"),
                    deathdate=stolperstein_serializer.data.get("deathdate"),
                    birthplace=stolperstein_serializer.data.get("birthplace"),
                    deathplace=stolperstein_serializer.data.get("deathplace"),
                    info_text=stolperstein_serializer.data.get("info_text"),
                    family_text=stolperstein_serializer.data.get("family_text"),
                )
        # For extracting the relation ID
        stolperstein_relations_initial = stolperstein_serializer.initial_data.get("stolperstein_relations")
        stolperstein_relations = stolperstein_serializer.data.get("stolperstein_relations")
    
        if stolperstein_relations:
            for i in range(0, len(stolperstein_relations)):  
                relation = stolperstein_relations[i]
                rel_stolperstein=Stolperstein.objects.get(name=relation['related_stolperstein']['name'],
                    location=Location.objects.get(coordinates=relation['related_stolperstein']['location']['coordinates']))
                try:
                    id = stolperstein_relations_initial[i]['id'] # relation DB id
                    relation_obj = StolpersteinRelation.objects.get(id=id)
                    relation_obj.related_stolperstein=rel_stolperstein
                    relation_obj.type=relation['type']
                    relation_obj.text=relation['text']
                    relation_obj.save()
                except StolpersteinRelation.DoesNotExist or IndexError:
                    new_relation = StolpersteinRelation.objects.create(
                        stolperstein=stolperstein,
                        related_stolperstein=rel_stolperstein,
                        type=relation['type'],
                        text=relation['text']
                    )

        # For extracting life station IDs            
        life_stations_initial = stolperstein_serializer.initial_data.get("life_stations")
        life_stations = stolperstein_serializer.data.get("life_stations")

        if life_stations:
            for i in range(0, len(life_stations)):
                try: 
                    id = life_stations_initial[i]["id"] # life station DB id
                    station = life_stations[i]
                    station_obj = LifeStation.objects.get(id=id)
                    station_obj.coordinates=station["coordinates"]
                    station_obj.name=station["name"]
                    station_obj.text=station["text"]
                    station_obj.save()
                except LifeStation.DoesNotExist or IndexError:
                    new_station = LifeStation.objects.create(
                        stolperstein=stolperstein,
                        coordinates=station["coordinates"],
                        name=station["name"],
                        text=station["text"]
                    )
        
        info_textboxes_initial = stolperstein_serializer.initial_data.get("info_textboxes")
        info_textboxes = stolperstein_serializer.data.get("info_textboxes")
        if info_textboxes:
            for i in range(0, len(info_textboxes)):
                try:
                    id = info_textboxes_initial[i]["id"]
                    box = info_textboxes[i]
                    box_obj = Textbox.objects.get(id=id)
                    box_obj.title = box["title"]
                    box_obj.content = box["content"]
                    box_obj.save()
                except Textbox.DoesNotExist or IndexError:
                    new_box = Textbox.objects.create(
                        stolperstein=stolperstein,
                        title=box["title"],
                        content=box["content"]
                    )

        updatedStolperstein_serializer = StolpersteinModelSerializer(stolperstein)
        return Response(data=updatedStolperstein_serializer.data, status=status.HTTP_201_CREATED)

    else:
        return Response(data='Invalid data form, stolperstein could not be created.\n'+json.dumps(stolperstein_serializer.errors),
                         status=status.HTTP_400_BAD_REQUEST)
   
@api_view(['DELETE'])
@login_required
@permission_required("api.delete_stolperstein", raise_exception=True)
def api_delete_stolperstein(request, coords, id):
    if (coords == None or id == None): 
        return Response("Please provide Coordinates and an ID", status=status.HTTP_400_BAD_REQUEST) 
    try:
        location = Location.objects.get(coordinates=coords)
    except Location.DoesNotExist:
        return Response("Location does not exists, please check entered coordinates", status=status.HTTP_400_BAD_REQUEST)
    if request.user.is_superuser or is_authorized(request, location) or request.groups.filter(name="global_editor").exists():
        obj = get_object_or_404(Stolperstein, id=id)
        obj.delete()
    else: 
        return Response("Missing permission to delete this Stolperstein", status=status.HTTP_403_FORBIDDEN)
    return Response(data="Successfully deleted Stolperstein with ID="+str(id), status=status.HTTP_200_OK)

@api_view(['DELETE'])
@login_required
@permission_required("api.delete_location", raise_exception=True)
def api_delete_location(request, coords):
    if (coords == None): 
        return Response("Please provide Coordinates ", status=status.HTTP_400_BAD_REQUEST) 
    try:
        location = Location.objects.get(coordinates=coords)
    except Location.DoesNotExist:
        return Response("Location does not exists, please check entered coordinates")
    if request.user.is_superuser or is_authorized(request, location):
        location.delete()
    else: 
        return Response("Missing permission to delete this Location", status=status.HTTP_403_FORBIDDEN)
    return Response(data="Successfully deleted Location at Coordinates="+coords, status=status.HTTP_200_OK)

@api_view(['DELETE'])
@login_required
@permission_required("api.delete_stolperstein_relation", raise_exception=True)
def api_delete_relation(request, coords, id):
    try:
        location = Location.objects.get(coordinates=coords)
    except Location.DoesNotExist:
        return Response("Location does not exists, please check entered coordinates")
    else:
        if not is_authorized(request, location):
            return Response(data="No permission to modify data associated with the current location", status=status.HTTP_403_FORBIDDEN)
    try: 
        relation = StolpersteinRelation.objects.get(id=id)
    except StolpersteinRelation.DoesNotExist:
        return Response("Relation with id "+str(id)+" does not exist.", status=status.HTTP_404_NOT_FOUND)
    relation.delete()
    return Response(data="Deleted Relation with id "+str(id), status=status.HTTP_200_OK) 

@api_view(['DELETE'])
@login_required
@permission_required("api.delete_life_station", raise_exception=True)
def api_delete_lifestation(request, coords, id):
    try:
        location = Location.objects.get(coordinates=coords)
    except Location.DoesNotExist:
        return Response("Location does not exists, please check entered coordinates")
    else:
        if not is_authorized(request, location):
            return Response(data="No permission to modify data associated with the current location", status=status.HTTP_403_FORBIDDEN)
    try: 
        lifestation = LifeStation.objects.get(id=id)
    except LifeStation.DoesNotExist:
        return Response(data="Life station with id "+str(id)+" does not exist", status=status.HTTP_404_NOT_FOUND)
    lifestation.delete()
    return Response(data="Deleted Life Station with id "+str(id), status=status.HTTP_200_OK)

@api_view(['DELETE'])
@login_required
@permission_required("api.delete_textbox", raise_exception=True)
def api_delete_textbox(request, coords, id):
    try:
        location = Location.objects.get(coordinates=coords)
    except Location.DoesNotExist:
        return Response("Location does not exists, please check entered coordinates")
    else:
        if not is_authorized(request, location):
            return Response(data="No permission to modify data associated with the current location", status=status.HTTP_403_FORBIDDEN)
    try: 
        textbox = Textbox.objects.get(id=id)
    except Textbox.DoesNotExist:
        return Response(data="Textbox does not exist", status=status.HTTP_404_NOT_FOUND)
    textbox.delete()
    return Response(data="Textbox successfully deleted", status=status.HTTP_200_OK)

@api_view(['POST'])
@login_required
@permission_required("api.change_order", raise_exception=True)
def api_update_order(request, coords):
    try:
        location = Location.objects.get(coordinates=coords)
    except Location.DoesNotExist:
        return Response("Location does not exists, please check entered coordinates")

    # Check if the user that sent the request is responsible for the Location
    if not is_authorized(request, location):
        return HttpResponseForbidden(
            "You do not have the required permissions for this location")

    try:
        data = json.loads(request.body)
        order_arr = data["order"]
        ordered_stolpersteine = [
            Stolperstein.objects.get(id=stolperstein_id) for stolperstein_id in order_arr]
        # location = Location.objects.get(coordinates=coords)
        Order.objects.filter(location=location).delete()
        updated_stolpersteine = []
        for i, stolperstein_id in enumerate(order_arr):
            stolperstein = Stolperstein.objects.get(id=stolperstein_id)
            order = Order.objects.create(
                location=location,
                position=i,
                stolperstein=stolperstein
            )
            updated_stolpersteine.append((stolperstein.id, stolperstein.name, i))

        return Response(data=updated_stolpersteine, status=status.HTTP_200_OK)
    except Exception as e:
        return Response(data=e, status=status.HTTP_400_BAD_REQUEST)

# Tour related views
@api_view(['POST'])
@login_required
def api_create_tour(request):
    serializer = TourSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
@login_required
def api_edit_tour_locations(request, tour_id):
    try:
        tour = Tour.objects.get(id=tour_id)
    except Tour.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)
    

    edited_tour_locations = []
    for tour_location in request.data:
        tour_location_data = {
            'tour': tour_location['tour_id'],
            'location': tour_location['location_id'],
            'order': tour_location['order'],
            'is_active': tour_location['is_active'],
        }

        tour_location_id = tour_location.get('id', None)

        try:
            tour_location_instance = TourLocation.objects.get(id=tour_location_id)
        except TourLocation.DoesNotExist:
            tour_location_instance = None

        serializer = TourLocationSerializer(data=tour_location_data, instance=tour_location_instance, partial=True)

        if(serializer.is_valid()):
            serializer.save()
            edited_tour_locations.append(serializer.data)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['GET'])
@login_required
def api_all_tours(request):
    tours = Tour.objects.all()
    serializer = TourSerializer(tours, many=True, context={'request': request})
    return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['GET'])
@login_required
def api_get_tour(request, tour_id):
    try:
        tour = Tour.objects.get(id=tour_id)
        serializer = TourSerializer(tour)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except:
        return Response(status=status.HTTP_404_NOT_FOUND)
    
@api_view(['GET'])
@login_required
def api_tour_locations(request, tour_id):
    try:
        tour = Tour.objects.get(id=tour_id)
    except Tour.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)
    
    tour_location_data = TourLocation.objects.filter(tour_id=tour_id, is_active=True)

    serializer = TourLocationSerializer(tour_location_data, many=True, context={'request': request})

    return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['GET'])
@login_required
def api_all_tour_locations(request):
    tour_location_data = TourLocation.objects.filter(is_active=True)

    serializer = TourLocationSerializer(tour_location_data, many=True, context={'request': request})

    return Response(serializer.data, status=status.HTTP_200_OK)


@api_view(['GET'])
@login_required
def api_get_locations_in_tour(request, tour_id):
    try:
        tour = Tour.objects.get(id=tour_id)
    except Tour.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)
    
    tour_location_data = TourLocation.objects.filter(tour_id=tour_id, is_active=True).order_by('order')

    location_ids = [tour_location.location_id for tour_location in tour_location_data]

    locations = Location.objects.filter(id__in=location_ids)

    sorted_locations = sorted(locations, key=lambda x: location_ids.index(x.id))

    serializer = LocationModelSerializer(sorted_locations, many=True, context={'request': request})
    
    return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['DELETE'])
@login_required
def api_delete_tour(request, tour_id):
    try:
        tour = Tour.objects.get(id=tour_id)
    except Tour.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    tour.delete()

    return Response(data="Successfully deleted tour with ID="+ str(tour_id), status=status.HTTP_200_OK)

# Adding Data Legacy for compatibility

def index(request):
    '''
    Render main page.
    '''
    context = {
        'new_location': '/new_location',
        'edit_location': '/location',
        'locations': list(Location.objects.values_list('coordinates', flat=True)),
    }
    return render(request, 'index.html', context)


def choose_location(request):
    '''
    Render page to choose a stolperstein location.
    '''
    context = {
        'link': f'/new_stolperstein/',
        'locations': list(Location.objects.values_list('coordinates', flat=True)),
    }
    return render(request, 'choose_location.html', context)

@permission_required('api.add_stolperstein', raise_exception=True)
def new_stolperstein(request, coords):

    # Renders a form, to add a new stolperstein at the specified location

    # Only allow adding stolperstein for existing location
    try:
        location = Location.objects.get(coordinates=coords)
    except Location.DoesNotExist:
        return redirect(location_not_found, coords)

    if not is_authorized(request, location):
        return HttpResponseForbidden(
            "You do not have the required permissions for this location")

    # If this is a POST request then process the Form data
    if request.method == 'POST':
        form = AddStolperstein(request.POST, request.FILES)
        life_stations_formset = LifeStationFormSet(
            data=request.POST, prefix="ls_form")
        related_stolpersteine_formset = StolpersteinRelationFormSet(
            data=request.POST, prefix="rel_form")
        if (form.is_valid()
            and life_stations_formset.is_valid()
                and related_stolpersteine_formset.is_valid()):

            stolperstein = Stolperstein.objects.create(
                name=form.cleaned_data["name"],
                photo=form.cleaned_data["photos"],
                reason_for_persecution=form.cleaned_data["reason_for_persecution"],
                location=location,
                placementdate=form.cleaned_data["placementdate"],
                birthdate=form.cleaned_data["birthdate"],
                deathdate=form.cleaned_data["deathdate"],
                birthplace=form.cleaned_data["birthplace"],
                deathplace=form.cleaned_data["deathplace"],
                info_text=form.cleaned_data["info_text"],
                family_text=form.cleaned_data["family_text"],
            )

            for life_station in life_stations_formset:
                ls_obj = life_station.save(commit=False)
                ls_obj.stolperstein = stolperstein
                ls_obj.save()

            for relation in related_stolpersteine_formset:
                rel_obj = relation.save(commit=False)
                rel_obj.stolperstein = stolperstein
                rel_obj.save()

            return redirect(location_overview, coords)

    # If this is a GET (or any other method) create empty form.
    else:
        form = AddStolperstein(initial={})
        life_stations_formset = LifeStationFormSet(
            queryset=LifeStation.objects.none(), prefix="ls_form")
        related_stolpersteine_formset = StolpersteinRelationFormSet(
            queryset=StolpersteinRelation.objects.none(), prefix="rel_form")

    context = {
        'main_form': form,
        'life_stations_formset': life_stations_formset,
        'related_stolpersteine_formset': related_stolpersteine_formset,
    }

    return render(request, 'new_stolperstein.html', context)


@permission_required('api.add_location', raise_exception=True)
def new_location(request):
    '''
    Renders a form, to add a new stolperstein location
    '''

    # If this is a POST request then process the returned coordinate
    if request.method == 'POST':
        form = AddLocation(request.POST)
        if form.is_valid():
            coords = form.cleaned_data["coordinates"]
            location = Location.objects.create(
                coordinates=coords,
                name=form.cleaned_data["name"]
            )
            location.responsible_users.add(request.user)
            return redirect(location_overview, coords)

    # If this is a GET (or any other method) let the user enter the coordinates.
    else:
        form = AddLocation(initial={})

    context = {
        'form': form,
    }

    return render(request, 'new_location.html', context)


@login_required
@permission_required('api.add_order', raise_exception=True)
def location_overview(request, coords):
    '''
    Renders a page that displays overview over stolpersteine at location
    '''

    try:
        location = Location.objects.get(coordinates=coords)
    except Location.DoesNotExist:
        return redirect(location_not_found, coords)

    if not is_authorized(request, location):
        return HttpResponseForbidden(
            "You do not have the required permissions for this location")

    stolpersteine = Stolperstein.objects.filter(
        location=location).order_by('order__position')

    context = {
        "stolpersteine": stolpersteine,
        "location": location,
        "update_order_url": "/update_order",
        "coords": coords,
        "new_stolperstein_url": "/new_stolperstein",
        "delete_stolperstein_url": "/delete_stolperstein"

    }

    return render(request, "location_overview.html", context)


@permission_required('api.change_order', raise_exception=True)
def update_order(request, coords):
    '''
    Processes Post request for order of stolpersteine
    '''

    try:
        location = Location.objects.get(coordinates=coords)
    except Location.DoesNotExist:
        return redirect(location_not_found, coords)

    # Check if the user that sent the request is responsible for the Location
    if not is_authorized(request, location):
        return HttpResponseForbidden(
            "You do not have the required permissions for this location")

    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            order_arr = data["order"]
            ordered_stolpersteine = [
                Stolperstein.objects.get(id=s_id) for s_id in order_arr]
            location = Location.objects.get(coordinates=coords)
            Order.objects.filter(location=location).delete()
            for i, s_id in enumerate(order_arr):
                stolperstein = Stolperstein.objects.get(id=s_id)
                order = Order.objects.create(
                    location=location,
                    position=i,
                    stolperstein=stolperstein
                )

            return HttpResponse(200)
        except Exception as e:
            return HttpResponseBadRequest()

    return HttpResponseNotFound()


@login_required
@permission_required('delete_stolperstein', raise_exception=True)
def delete_stolperstein(request, id, coords=None):

    if coords == None:
        if not request.user.is_superuser:
            return HttpResponseForbidden(
                "You dont have the rights to delete this Stolperstein")
        else:
            try:
                location = Location.objects.get(coordinates=coords)
            except Location.DoesNotExist:
                return redirect(location_not_found, coords)
            if not is_authorized(request, location):
                return HttpResponseForbidden(
                    "You do not have the required permissions for this location")

    # Fetch the object related to passed id
    obj = get_object_or_404(Stolperstein, id=id)
    if request.method == "POST":
        obj.delete()
    return HttpResponse(200)






# Success / Error Pages:

def location_not_found(request, coords):
    context = {
        'coordinates': coords
    }
    return render(request, "location_not_found.html", context)


def is_authorized(request, location):
    '''
    Check if the user that sent the request is authorized for that location
    '''

    # Gets the user name
    user = request.user
    # Authorized are responsible users, superusers and global editors
    if (location.responsible_users.filter(username=user.username).exists()
        or user.is_superuser
            or user.groups.filter(name="global_editor").exists()):
        return True
    return False
