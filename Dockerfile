FROM alpine:3.7

ENV LANG C.UTF-8
ENV ENV /etc/profile

RUN apk update \
    && apk add --no-cache \
        bash \
        docker \
        make \
        curl \
        git \
        build-base \
        bzip2-dev \
        readline-dev \
        postgresql-dev \
        sqlite-dev \
        linux-headers \
        libpq \
        zlib-dev

RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash \
    && echo 'export PATH="/root/.pyenv/bin:$PATH"' >> /etc/profile \
    && echo 'eval "$(pyenv init -)"' >> /etc/profile \
    && echo 'eval "$(pyenv virtualenv-init -)"' >> /etc/profile

RUN ~/.pyenv/bin/pyenv install 2.7.14
RUN ~/.pyenv/bin/pyenv install 3.5.5
RUN ~/.pyenv/bin/pyenv install 3.6.4

RUN ~/.pyenv/bin/pyenv global 2.7.14 3.5.5 3.6.4
RUN ~/.pyenv/shims/pip3 \
    --no-cache-dir \
    --disable-pip-version-check \
    install \
    mkdocs \
    pipenv==11.0.2 \
    alembic \
    psycopg2

COPY init.sh .
ENTRYPOINT [ "./init.sh" ]
