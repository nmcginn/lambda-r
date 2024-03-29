#!/bin/bash

# python virtualenv
virtualenv ~/env && source ~/env/bin/activate
pip install rpy2

# view native dependencies
ldd /usr/lib64/R/bin/exec/R

# start assembling binaries
rm /usr/lib64/R/lib/libRrefblas.so
cp -r /usr/lib64/R/* lambda/
cp /usr/lib64/R/lib/libR.so lambda/lib/libR.so

# all the binaries we need
cp /usr/lib64/libgomp.so.1 lambda/lib/
cp /usr/lib64/libgfortran.so.3 lambda/lib/
cp /usr/lib64/libquadmath.so.0 lambda/lib/
cp /usr/lib64/libblas.so.3 lambda/lib/
cp /usr/lib64/liblapack.so.3 lambda/lib/
cp /usr/lib64/libtre.so.5 lambda/lib/

# and finally the big enchilada
cp lambda/bin/exec/R lambda/

# and some python junk too
cp -r $VIRTUAL_ENV/lib/python2.7/site-packages/* lambda/
#cp -r $VIRTUAL_ENV/lib/python2.7/site-packages/singledispatch* lambda/

# MAKE THE PACKAGE
cd lambda/
zip -r9 here_we_go_boys.zip *

# after this, upload to the S3s, make sure things are proper, and deploy to lambda
aws s3 cp here_we_go_boys.zip $S3_URL
