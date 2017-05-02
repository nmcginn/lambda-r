#!/bin/bash

# python virtualenv
virtualenv ~/env && source ~/env/bin/activate
pip install rpy2 awscli

# view native dependencies
ldd /usr/lib/R/bin/exec/R

# start assembling binaries
cp -r /usr/lib/R/* lambda/
cp /usr/lib/R/lib/libR.so lambda/lib/libR.so

# pontentially missing other libraries as well, make it work
cp /usr/lib/x86_64-linux-gnu/libgomp.so.1 lambda/lib/
cp /usr/lib/x86_64-linux-gnu/libgfortran.so.3 lambda/lib/
cp /usr/lib/x86_64-linux-gnu/libquadmath.so.0 lambda/lib/
cp /lib/x86_64-linux-gnu/libm.so.6 lambda/lib/
cp /lib/x86_64-linux-gnu/libc.so.6 lambda/lib/
cp /lib/x86_64-linux-gnu/libpcre.so.3 lambda/lib/
cp /lib/x86_64-linux-gnu/libbz2.so.1.0 lambda/lib/
cp /lib/x86_64-linux-gnu/libgcc_s.so.1 lambda/lib/
cp /usr/lib/libblas.so.3 lambda/lib/
cp /usr/lib/liblapack.so.3 lambda/lib/

# and finally the big enchilada
cp lambda/bin/exec/R lambda/

# and some python junk too
cp -r $VIRTUAL_ENV/lib/python2.7/site-packages/* lambda/
cp -r $VIRTUAL_ENV/lib/python2.7/site-packages/singledispatch* lambda/

# MAKE THE PACKAGE
cd lambda/
zip -r9 here_we_go_boys.zip *

# after this, upload to the S3s, make sure things are proper, and deploy to lambda
aws s3 cp here_we_go_boys.zip $S3_URL
