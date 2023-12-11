FROM python:3.11
#Переменная для того, чтобы пакет соответствовал порядку именования *.deb пакетов
ARG DEB_FORM=_1.0-1_all.deb
#Переменная для смены модуля
ARG PY_MODUL=https://files.pythonhosted.org/packages/70/fc/6eaaed941959914e29463100802cb7ad55b747960d2ce8a93b9a2ebe6fb7/bwenv-1.0.0.tar.gz
#ENV для того чтобы переназначить модуль во время запуска контейнера
ENV PY_MODUL=$PY_MODUL
#ENV для того чтобы переименовать модуль во время запуска контейнера
ENV DEB_FORM=$DEB_FORM
#Утилиты для сбора deb пакета
RUN apt-get update && apt-get install -y dpkg fakeroot && pip install --no-cache-dir --upgrade pip -r /tmp/requirements.txt

WORKDIR /app

COPY . /var/modul

WORKDIR /var/modul
#Сборка пакета .deb
RUN wget $PY_MODUL && fakeroot dpkg-deb --build /var/modul  \
    && mv /var/modul.deb /var/modul$DEB_FORM

CMD bash