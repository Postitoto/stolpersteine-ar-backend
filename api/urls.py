from django.urls import include, path
from django.conf import settings
from django.conf.urls.static import static
from rest_framework import routers
from . import views
from rest_framework.authtoken import views as rest_framework_views

# Wire up API using automatic URL routing.
router = routers.DefaultRouter()
router.register(r'stolpersteine', views.StolpersteinViewSet)
router.register(r'locations', views.LocationViewSet)
router.register(r'lifestations', views.LifeStationViewset)
router.register(r'relations', views.StolpersteinRelationViewset)
router.register(r'full_relations', views.FullStolpersteinRelationViewset)

urlpatterns = [
   # Administrative
   path('overview/', include(router.urls)),
   path('api-auth/', include('rest_framework.urls',
                           namespace='rest_framework')),
   # API for retrieving and modifying data

   ### legacy paths ###
   path('get_coordinates/', views.all_locations,
      name="all stolperstein coordinates"),
   path('get_stolpersteine/<str:coords>', views.stolpersteine_at,
      name="stolpersteine at location"),
   ### new api access ###
   path('api/get-locations/', views.all_locations,
      name="view all stolperstein locations"),
   path('api/add-location/', views.api_add_location,
      name="add new location"),
   path('api/get-stolpersteine/<str:coords>', views.stolpersteine_at,
      name="get all stolpersteine at location"),
   path('api/stolpersteine/', views.api_all_stolpersteine,
      name="get all stolpersteine"),
   path('api/stolpersteine/<int:id>', views.api_stolperstein_by_id,
      name="get specific stolperstein by its id"),
   path('api/add-stolperstein/<str:coords>', views.api_add_stolperstein,
      name="add stolperstein to existing location"),
   path('api/assets/<int:stolpersteinId>', views.api_add_stolperstein_assets,
      name='upload stolperstein assets'),
   path('api/delete-stolperstein/<str:coords>/<int:id>', views.api_delete_stolperstein,
      name="delete stolperstein from location"),
   path('api/delete-location/<str:coords>', views.api_delete_location,
      name="delete location"),
   path('api/relation/delete/<str:coords>/<int:id>', views.api_delete_relation, 
      name="delete a relation by id"),
   path('api/lifestation/delete/<str:coords>/<int:id>', views.api_delete_lifestation, 
      name="delete a lifestation by id"),
   path('api/order/<str:coords>', views.api_update_order, 
      name="update stolperstein order"),
   path('api/textbox/delete/<str:coords>/<int:id>', views.api_delete_textbox,
      name="delete textbox"),
   # Legacy Adding Data
   path('', views.index, 
      name="main page"),
   path('choose_location/', views.choose_location, 
      name="choose location"),
   path('new_stolperstein/<str:coords>', views.new_stolperstein,
      name="new stolperstein"),
   path('new_location/', views.new_location,
      name="new location"),
   path('location/<str:coords>', views.location_overview,
      name="location overview"),
   path('update_order/<str:coords>', views.update_order,
      name="update order"),
   path('delete_stolperstein/<int:id>/<str:coords>', views.delete_stolperstein,
      name="delete stolperstein"),
    # authentication pages
    path('accounts/', include('django.contrib.auth.urls')),
    # get token
    path('api/get-auth-token', rest_framework_views.obtain_auth_token, name='get_auth_token'),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT) \
  + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
