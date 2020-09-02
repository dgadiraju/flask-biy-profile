FROM python:3.7

WORKDIR /app
COPY requirements.txt requirements.txt

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install telnet postgresql-client-common postgresql-client
RUN apt-get clean
RUN pip install -r requirements.txt

EXPOSE 5000
ENV FLASK_APP=app.py
ENV FLASK_ENV=development

CMD ["flask", "run", "--host", "0.0.0.0", "--port", "5000"]