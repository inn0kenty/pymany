FROM ubuntu:latest

RUN apt-get update \
    && apt-get install -y \
       make \
       build-essential \
       libssl-dev \
       zlib1g-dev \
       libbz2-dev \
       libreadline-dev \
       libsqlite3-dev \
       wget \
       curl \
       llvm \
       libncurses5-dev \
       libncursesw5-dev \
       xz-utils \
       tk-dev \
       git

SHELL ["/bin/bash", "-c"]

RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash \
    && echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc \
    && echo 'eval "$(pyenv init -)"' >> ~/.bashrc \
    && echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc \
    && source ~/.bashrc

RUN ~/.pyenv/bin/pyenv install 2.7.14
RUN ~/.pyenv/bin/pyenv install 3.5.5
RUN ~/.pyenv/bin/pyenv install 3.6.4

RUN ~/.pyenv/bin/pyenv global 2.7.14 3.5.5 3.6.4
