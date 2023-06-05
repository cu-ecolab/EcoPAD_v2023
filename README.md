# EcoPAD_v2023
A new version of EcoPAD based on new CyberCommon which puts all component to containers (Jian) - From 5/22/2023.  

EcoPAD is consist of **CyberCommons framework** and specific functions of **ecopad**.  
- CyberCommons is developed by "https://github.com/cybercommons/cybercommons". You can see the documents about it in "https://ou-ecolab.github.io/cybercommons/". It provides a loosely coupled service-orientated reference architecture for distributed computing workflows, which includes the containers of MongoDB, RabbitMQ, Django Restfull and Celery that are combined by Python RESTful API.

- ecopad provides the specific functions to do ecological forecasting, which includes the data assimilation, simulation by processes-based models (e.g. TECO model) or other data-diven or matrix form models, and automatically forecast.


# Pre-work
- pull the CyberCommon and ecopadq from the github of ou-ecolad that developed by Markus (5/22/2023).
- change some documents in EcoPAD, such as the "ecopadq" to "ecopad"  
- some relative processes can be seen in https://github.com/ou-ecolab/ecopad. 


# Modification:  

## 2023.06.02
**startCeleryWorker.py needs to modify the source of url for installing by "pip". Otherwise, celeryapp can not run.**  

modify the url path in the ecopad_portal.  
**Problem**: "s://ecopad.cals.cornell.edu/ecopad_portal/' was loaded over HTTPS, but requested an insecure XMLHttpRequest endpoint 'http://ecopad.cals.cornell.edu/api/queue/run/ecopadq.tasks.tasks.test_run_simulation/'. This request has been blocked; the content must be served over HTTPS."  
**Solution**: add "<meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">" to index.html.  
**Problem**: "ecopadq.tasks.tasks.test_run_simulation Task is not available"(check api container)  
**Solution**: "..."

## 2023.06.01
To make the EcoPAD more independent, I move the new settings out from the cybercommon, so that we can do some modifications without considering the settings of cybercommon. But there are still some places that needs to be modifyed in cybercommon:  
    
    1. "cybercommons/dc_config/images/docker-compose-init.yml" must delete the build content.  
    2. The Dockerfile in cybercommon which used to set up the cybercomm_api that need add the url source for the installation using "pip install -r requirements" in container.  
    3. The dockerfile in "cybercommons/dc_config/images/celery/Dockerfile" also need add the source of url to install packages by "pip install -r requirements" in container.  

The other things is:  
    
    1. copy the "cybercommons/docker-compose.yml" to the main folder and modify the relative path in it.  
    2. copy the "cybercommons/Makefile" to the main folder and modify the relative contents.  
    3. add the file of "ecopad_config.env" to set the modification of "cybercommons/dc_config/cybercom_config.env" or add some new settings.
    4. add the folder of "web" to replace the "cybercommons/web".
    5. copy the folder of "cybercommons/dc_config/ssl/nginx/letsencrypt_cornell" to folder of "ecopad_rel". "ecopad_rel" can be used to put some special files for EcoPAD.  
#  
### Continue to add what I have done to the new version of EcoPAD.  


#  
## 2023.05.22  
Using the original version of CyberCommon from "https://github.com/cybercommons/cybercommons"instead of the version of Markus. Because we need make the CyberCommon as a independent framework for EcoPAD, we should avoid modifying the code within this framework as much as possible. Instead, it is preferable to use additional containers to connect it.