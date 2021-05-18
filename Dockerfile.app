FROM python:3.8.5
LABEL author="mario@clinfo.com.br"

COPY wkhtmltox_0.12.6-1.buster_amd64.deb \
     uwsgi.ini \
     requirements.txt /requirements/

RUN apt-get update ; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils ; \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update ; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends mc ; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends net-tools ; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends xfonts-utils ; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends xfonts-75dpi ; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends xfonts-base ; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends libfontenc1 ; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends xfonts-encodings ; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends --reinstall locales ; \
    rm -rf /var/lib/apt/lists/*

RUN export TZ="America/Sao_Paulo" ; \
    export LANG="pt_BR.UTF-8" ; \
    export LANG="pt_BR.UTF-8" ; \
    export LANGUAGE="pt_BR.UTF-8" ; \
    export LC_ALL="pt_BR.UTF-8" ; \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone ; \
    locale-gen pt_BR.UTF-8 ; \
    sed -i 's/# pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/' /etc/locale.gen ; \
    localedef -i pt_BR -c -f UTF-8 -A /usr/share/locale/locale.alias pt_BR.UTF-8 ; \
    dpkg-reconfigure --frontend noninteractive locales ; \
    echo "\nexport TERM=xterm" >> /etc/bash.bashrc ; \
    echo "alias dir='ls --color=auto -lAsh'" >> /root/.bashrc

RUN dpkg -i /requirements/wkhtmltox_0.12.6-1.buster_amd64.deb ; \
    rm -rf /requirements/wkhtmltox_0.12.6-1.buster_amd64.deb ; \
    python -m pip install --upgrade pip ; \
    pip install --no-cache-dir -r /requirements/requirements.txt ; \
    pip install --no-cache-dir uWSGI

WORKDIR /app

CMD ["uwsgi --ini /requirements/uwsgi.ini"]
