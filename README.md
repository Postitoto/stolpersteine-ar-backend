# Stolpersteine AR Backend

## Installation Instructions

1. Install Python3 

2. [Install Virtual Environment](https://code.visualstudio.com/docs/python/tutorial-django)

```bash
# Linux
sudo apt-get install python3-venv    # If needed
python3 -m venv .venv
source .venv/bin/activate

# macOS
python3 -m venv .venv
source .venv/bin/activate

# Windows
py -3 -m venv .venv
.venv\scripts\activate
```

3. [Install Requirements](https://code.visualstudio.com/docs/python/tutorial-django#_create-a-requirementstxt-file-for-the-environment)
```bash
pip3 install -r requirements.txt
```
If you add additional requirements you can update your requirements.txt simply by using the command
```bash
pip3 freeze > requirements.txt
```
4. Set Environment Variables

If you want to run the Django server in your local environment you can continue to the next step.
In a production environment make sure to set the following environment variables:
```bash
export DJANGO_DEBUG=False
export SECRET_KEY=<your-django-secret-key>
```
This project uses a cloud storage for saving images and other media files. 
If you want to save your media files locally, perform the required code changes mentioned in settings.py and models.py and skip the following step. The used cloud storage is Cloudinary. Cloudinary requires these three environment variables to be set:
```bash
export CLOUD_NAME_CLOUDINARY=<cloud-name>
export API_KEY_CLOUDINARY=<api-key>
export API_SECRET_CLOUDINARY=<api-secret>
```

Depending on your production environment you may have a GUI to set environment variables. This Django project is configured to run on [Heroku](https://www.heroku.com).

5. Run Development Server 
```
python3 manage.py runserver
```
In case you are using an external hosting provider you don't need this step.

## Running the Django server on Heroku (taken from this [Tutorial](https://developer.mozilla.org/en-US/docs/Learn/Server-side/Django/Deployment))

0. Install the Heroku CLI

Follow the [installation guide](https://devcenter.heroku.com/articles/getting-started-with-python#set-up) suitable for your environment.

In case you are using Ubuntu (or a similar distribution) within the Windows Subsystem for Linux (WSL2) you can install the CLI via Shellscript which does not require Snap.
```bash
curl https://cli-assets.heroku.com/install.sh | sh
```

1. Create a git remote for heroku

In case this is the first deployment run the following command.
```
heroku create
```

2. Push the app to heroku

The following command pushes your main branch to the heroku remote main branch and starts the app. It also executes the collectstatic command. 
```
git push heroku main
``` 
In case this is the first deployment (or you have made changes to your models) make sure to perform the migrate command 
```
heroku run python manage.py migrate
```
and to create a superuser. Follow the Tutorial linked above for more information.
