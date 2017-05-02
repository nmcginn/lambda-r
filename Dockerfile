from amazonlinux:latest

RUN yum -y update && yum -y upgrade
RUN yum install -y python27-devel python27-pip gcc gcc-c++ readline-devel libgfortran.x86_64 R.x86_64 zip
#RUN yum install -y openblas lapack

RUN R -e 'options(repos=structure(c(CRAN="http://cran.wustl.edu/")));install.packages("survival")'
RUN pip install virtualenv rpy2 awscli

ENV AWS_ACCESS_KEY_ID=""
ENV AWS_SECRET_ACCESS_KEY=""
ENV S3_URL=""

RUN mkdir -p /lambda/lib
COPY script.sh /
COPY lambda/handler.py /lambda/

CMD ["/script.sh"]
