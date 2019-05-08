FROM python:3.7.3-slim
LABEL maintainer="Matthew Vincent <mattjvincent@gmail.com>" \
	  version="1.0"

RUN apt-get update && \
    apt-get -y install gcc

ENV INSTALL_PATH /app/qtlweb
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

RUN pip install --upgrade pip
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY . .
RUN pip install --editable .

CMD gunicorn -c "python:config.gunicorn" "qtlweb.app:create_app()"
