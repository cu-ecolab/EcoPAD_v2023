ARG DOCKER_PYTHON_VERSION=3.9-slim-bullseye
FROM python:$DOCKER_PYTHON_VERSION

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 PYTHONUNBUFFERED=1 

RUN sh -c 'echo "deb https://mirrors.ustc.edu.cn/debian/ buster main" > /etc/apt/sources.list'

RUN apt-get update && apt-get install -y \
    git \
    imagemagick \
    libimage-exiftool-perl \
    libtiff-dev \
    libxml2-dev \
    libxslt-dev \
    libopenjp2-7 \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /   
COPY requirements.txt ./  
RUN pip install --no-cache-dir -r requirements.txt --index-url https://pypi.tuna.tsinghua.edu.cn/simple\
  && rm requirements.txt  

COPY . /app  
WORKDIR /app

#Setup Celery User
RUN useradd -r -U -m celery \
  && chown celery:celery -R /app

USER celery

CMD ["/app/startCeleryWorker"]
