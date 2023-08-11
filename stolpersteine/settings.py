import os
import dj_database_url
"""
Django settings for stolpersteine project.

Generated by 'django-admin startproject' using Django 3.2.

For more information on this file, see
https://docs.djangoproject.com/en/3.2/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/3.2/ref/settings/

Information for additional configuration for deployment on Heroku
taken from: https://developer.mozilla.org/en-US/docs/Learn/Server-side/Django/Deployment
"""

from pathlib import Path

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = os.environ.get('DJANGO_DEBUG', '') != 'False'

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent
if DEBUG:
    MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
    MEDIA_URL = '/media/'

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/3.2/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'django-insecure-$@t3-g-i$%o%c%ax21a2^spd6)gk0cz#(#17lt4@c@xp=hdxu7'

# In Production load actual secure key from file
if not DEBUG:
    # assuming an environment variable SECRET_KEY is set with the appropriate key
    # create a secure key therefore
    SECRET_KEY = os.environ['SECRET_KEY'] 

# initially was empty, '192.168.178.22' is ipv4 addr. at home, '192.168.0.105' is ipv4 stusta, '192.168.0.101'
# cryptic-depths is an automatic generated URL by Heroku hosting provider
ALLOWED_HOSTS = [
    'localhost', 
    '127.0.0.1', 
    '192.168.178.22', 
    '192.168.0.105', 
    '192.168.0.101', 
    '192.168.0.106', 
    '172.28.47.251']

if not DEBUG: 
    ALLOWED_HOSTS = ['*']

# CSRF SECURE
CSRF_COOKIE_SECURE = True

#Secure Session Cookie
SESSION_COOKIE_SECURE = True

# Application definition

INSTALLED_APPS = [
    'api.apps.ApiConfig',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'cloudinary_storage',
    'django.contrib.staticfiles',
    'cloudinary',
    'rest_framework',
    'rest_framework.authtoken',
    'django_extensions',
    'corsheaders'
]

MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.security.SecurityMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',

]

ROOT_URLCONF = 'stolpersteine.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'stolpersteine.wsgi.application'


# Database
# https://docs.djangoproject.com/en/3.2/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'stolpersteine_ar_database',
        'USER': 'stolpersteine_ar_database_user',
        'PASSWORD': 'XKbt05masQL5GQcsOqlrty41GGFmvyTi',
        'HOST': 'dpg-cjaeh0ee546c738s87eg-a.frankfurt-postgres.render.com',
        'PORT': '5432',
    }
}

# For Heroku Deployment: update database configuration from DATABASE_URL
# Note: On Production environment set above mentioned environment variable!!!
# Note: on local dev environment sqlite db will still be used as long as 
# environment variable is not set
db_from_env = dj_database_url.config(conn_max_age=500)
DATABASES['default'].update(db_from_env)

# Password validation
# https://docs.djangoproject.com/en/3.2/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

# Token Authentication
# https://chrisbartos.com/articles/how-to-implement-token-authentication-with-django-rest-framework/
REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework.authentication.TokenAuthentication',
    ),
    'DEFAULT_PERMISSION_CLASSES': (
        'rest_framework.permissions.IsAuthenticated',
    )
}


# Internationalization
# https://docs.djangoproject.com/en/3.2/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/3.2/howto/static-files/

# The absolute path to the directory where collectstatic will collect static files for deployment.
if not DEBUG:
    STATIC_ROOT = BASE_DIR / 'staticfiles'
    STATICFILES_STORAGE = 'cloudinary_storage.storage.StaticHashedCloudinaryStorage'

# The URL to use when referring to static files (where they will be served from)
STATIC_URL = '/static/'

# Default primary key field type
# https://docs.djangoproject.com/en/3.2/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

# Redirect to home URL after login (Default redirects to /accounts/profile/)
LOGIN_REDIRECT_URL = '/'

EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'

# CORS Settings
CORS_ORIGIN_ALLOW_ALL = False
CORS_ORIGIN_WHITELIST = (
  'http://localhost:4200',
  'https://stolperstein-manager.web.app',
)


CLOUDINARY_STORAGE = {
'CLOUD_NAME': os.environ.get('CLOUD_NAME_CLOUDINARY'),
'API_KEY': os.environ.get('API_KEY_CLOUDINARY'),
'API_SECRET': os.environ.get('API_SECRET_CLOUDINARY'),
}

# Setting up cloudinary cloud storage
# REMOVE THIS IF YOU WANT TO USE YOUR LOCAL HARDDRIVE FOR TESTING
# ALSO CHANGE THE MODEL IN models.py
MEDIA_URL = '/public/'
DEFAULT_FILE_STORAGE = 'cloudinary_storage.storage.MediaCloudinaryStorage'