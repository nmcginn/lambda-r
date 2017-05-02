from ubuntu:xenial

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    bash-completion \
    ca-certificates \
    file \
    fonts-texgyre \
    g++ \
    gfortran \
    gsfonts \
    libbz2-dev \
    libcurl3 \
    libicu-dev \
    libopenblas-dev \
    libpangocairo-1.0-0 \
    libpaper-utils \
    libpcre3-dev \
    libpng12-0 \
    libreadline-dev \
    libtiff5 \
    libtcl8.6 \
    libtk8.6 \
    libxt6 \
    liblzma5 \
    liblzma-dev \
    locales \
    python-dev \
    python-pip \
    make \
    unzip \
    virtualenv \
    wget \
    xdg-utils \
    zip \
    zlib1g-dev

RUN wget https://cran.r-project.org/bin/linux/ubuntu/xenial/r-base-core_3.4.0-1xenial0_amd64.deb
RUN dpkg -i r-base-core_3.4.0-1xenial0_amd64.deb && rm r-base-core_3.4.0-1xenial0_amd64.deb

RUN R -e 'options(repos=structure(c(CRAN="http://cran.wustl.edu/")));install.packages("survival")'
COPY script.sh /

ENV AWS_ACCESS_KEY_ID=""
ENV AWS_SECRET_ACCESS_KEY=""
ENV S3_URL=""

CMD ["/script.sh"]
