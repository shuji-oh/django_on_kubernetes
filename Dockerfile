FROM python:3.7

ARG ENV

RUN mkdir /code/
WORKDIR /code/
ADD ./python-docs-samples/kubernetes_engine/django_tutorial/ /code
RUN cd /code
COPY $ENV /code

RUN pip install --upgrade pip && \
	pip install pipenv && \
	pipenv --python /usr/local/bin/python && \
	pipenv install

CMD pipenv run python manage.py collectstatic
CMD pipenv run gunicorn mysite.wsgi:application --bind 0.0.0.0:8000