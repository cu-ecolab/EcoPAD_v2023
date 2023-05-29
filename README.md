# EcoPAD_v2023
A new version of EcoPAD based on new CyberCommon which puts all component to containers (Jian) - 5/22/2023.  

EcoPAD is consist of **CyberCommons framework** and specific functions of **ecopad**.  
- CyberCommons is developed by "https://github.com/cybercommons/cybercommons". You can see the documents about it in "https://ou-ecolab.github.io/cybercommons/". It provides a loosely coupled service-orientated reference architecture for distributed computing workflows, which includes the containers of MongoDB, RabbitMQ, Django Restfull and Celery that are combined by Python RESTful API.

- ecopad provides the specific functions to do ecological forecasting, which includes the data assimilation, simulation by processes-based models (e.g. TECO model) or other data-diven or matrix form models, and automatically forecast.


# Pre-work
- pull the CyberCommon and ecopadq from the github of ou-ecolad that developed by Markus (5/22/2023).
- change some documents in EcoPAD, such as the "ecopadq" to "ecopad"

# Modification:  
## 2023.05.22  
Using the original version of CyberCommon from "https://github.com/cybercommons/cybercommons"instead of the version of Markus. Because we need make the CyberCommon as a independent framework for EcoPAD, we should avoid modifying the code within this framework as much as possible. Instead, it is preferable to use additional containers to connect it.