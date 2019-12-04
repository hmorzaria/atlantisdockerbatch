FROM rocker/r-ver:latest
MAINTAINER hmorzaria@hotmail.com
# Install minimum requirements
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    subversion \
    gdebi-core \
    gdal-bin \
    libcairo2 \
    libcairo2-dev \
    libapparmor1 \
    libhdf5-dev \
    libnetcdf-dev \
    libgdal-dev \
    libssl-dev \
    libudunits2-dev \
    libxml2-dev \
    libproj-dev \
    flip \
    automake

#Install AzCopy, ver. 7.2 includes .NET Core dependencies; they do not
#need to install them a pre-requisite
#https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-linux
RUN \
    apt-get update && apt-get -y upgrade &&\
    apt-get -y install rsync wget &&\
    wget -O azcopy.tar.gz https://aka.ms/downloadazcopylinuxrhel6 &&\
    tar -xzf azcopy.tar.gz &&\
    ./install.sh &&\
    rm -Rf azcopy* install.sh
    
    #setup R configs

 RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
 RUN Rscript -e "install.packages( c( \
    'digest', \
    'readxl', \
    'RNetCDF', \
    'httr', \
    'tidyverse'), \
    dependencies = TRUE)"
    
ENV TZ America/Los_Angeles
RUN ln -snf /usr/share/timezone/$TZ /etc/localtime && echo $TZ > /etc/timezone

CMD ["R"]
