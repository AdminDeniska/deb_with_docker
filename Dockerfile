FROM python:3.11-alpine

RUN apt-get update && apt-get install -y python3-stdeb python3-all fakeroot

WORKDIR /backend

COPY backend /var

RUN pip install --no-cache-dir --upgrade pip -r /var/requirements.txt

WORKDIR /var

RUN python main.py --command-packages=stdeb.command sdist_dsc && \
    dpkg-buildpackage -us -uc -rfakeroot && dpkg -i python-var.deb
