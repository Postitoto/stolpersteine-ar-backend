# Stolpersteine AR Backend

## Installation Instructions

1. Install Python3. Version 3.8.10 works for sure.

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

Depending on your production environment you may have a GUI to set environment variables. This Django project is configured to run on [Render](https://render.com/).

5. Database

The database was also hosted on Render. Sadly, free databases are deleted after 3 months there so the database I worked with is not online anymore.

I created an SQL dump file which is located in this folder under 'stolpersteine_dump.sql'

If you choose to continue using Render as a host for the database you can restore this file by following these steps.

- Go to https://dashboard.render.com/

- Click on the 'New +' button, select PostgreSQL and fill out the field as you desire. Click on 'Create Database', this will take some time.

- If you're not working on Windows you can skip this step: Install wsl on your windows machine and select a Linux distro: https://learn.microsoft.com/en-us/windows/wsl/install

- Install the postgres-client with 'sudo apt-get install postgresql-client'

- Now the following command should restore the dump file into your database when replacing the placeholders with your information:

```
pg_restore -h <host> -p <port> -U <username> -d <database_name> -W -F c -c <dump_file>
```

- Similarly, you can crate a dump using this command:

```
pg_dump -h <host> -p <port> -U <username> -d <database_name> -f <output_file.sql>
```

6. Run Development Server 
```
python3 manage.py runserver
```
In case you are using an external hosting provider you don't need this step.


