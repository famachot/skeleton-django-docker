FROM python:3.6
ENV PYTHONUNBUFFERED 1
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LC_ALL en_US.UTF-8 
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en 
RUN mkdir /app
RUN mkdir -p /repo_app/api_apoyos
WORKDIR /app
COPY requirements.txt /app/
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

RUN mkdir /var/log/django
RUN touch /var/log/django/api-encuestas.log
COPY . /app/
# CMD ["gunicorn", "--bind", "0.0.0.0:1028", "config.wsgi"]
