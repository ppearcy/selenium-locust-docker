FROM python:3.8.0-alpine3.10

COPY requirements.txt requirements.txt
RUN apk --no-cache add --virtual=.build-dep \
      build-base \
    && apk --no-cache add bash libzmq linux-headers zeromq-dev chromium chromium-chromedriver \
    && pip install -r requirements.txt \
    && apk del .build-dep

# COPY licenses, sample tasks and entrypoint into root
COPY app /

# Set script to be executable
RUN chmod 755 /entrypoint.sh

# Expose the required Locust ports
EXPOSE 5557 5558 8089

# Start Locust using LOCUS_OPTS environment variable
ENTRYPOINT ["/entrypoint.sh"] 
