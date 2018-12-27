
FROM alpine:latest

# Install system dependencies
RUN apk add --no-cache --update \
  bash \
  gcc \
  musl-dev \
  postgresql-dev \
  python3 \
  python3-dev \
  py3-pip
RUN pip3 install --no-cache-dir -q pipenv

# Add our code
ADD ./ /opt/webapp/
WORKDIR /opt/webapp

# Install dependencies
RUN pipenv install --deploy --system

# Run the image as a non-root user
RUN adduser -D myuser
USER myuser

CMD waitress-serve --port=$PORT dancrowdboticscom_dan_53.wsgi:application
