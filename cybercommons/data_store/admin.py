from django.contrib import admin
from django.contrib.contenttypes.models import ContentType
from django.contrib.auth.models import Permission
# Register your models here.
from api import config
from .models import dataStore
#from pymongo import MongoClient
from celery import Celery


class celeryConfig:
    BROKER_URL = config.BROKER_URL
    BROKER_USE_SSL = config.BROKER_USE_SSL
    CELERY_SEND_EVENTS = True
    CELERY_TASK_RESULT_EXPIRES = None
    CELERY_RESULT_BACKEND = config.CELERY_RESULT_BACKEND
    CELERY_MONGODB_BACKEND_SETTINGS = config.CELERY_MONGODB_BACKEND_SETTINGS


app = Celery()
app.config_from_object(celeryConfig)


def setpermissions(app_label,codename,name):
    try:
        ct = ContentType.objects.get_for_model(dataStore)
        #ct=ContentType.objects.get(app_label=app_label)
        Permission.objects.get_or_create(codename=codename, name=name, content_type=ct)
    except:
         print("Unable to create {0} permission.".format(codename))

#data Store Permissions
#db = MongoClient(host=config.DATA_STORE_MONGO_URI)
db = app.backend.database.client
for database in db.list_database_names():
    if not (database in config.DATA_STORE_EXCLUDE):
        for col in db[database].list_collection_names():
            if not (col in config.DATA_STORE_EXCLUDE):
                for method in [('post','ADD'),('put','UPDATE'),('delete','DELETE'),('safe','SAFE METHODS')]:
                    codename= "{0}_{1}_{2}".format(database,col,method[0])
                    name = "Data Store {0} {1} {2}".format(database,col,method[1])
                    setpermissions('data_store',codename,name)

#create admin permissions
setpermissions('data_store','datastore_admin',"Data Store Admin")
