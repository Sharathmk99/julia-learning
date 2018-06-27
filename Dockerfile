FROM ubuntu:14.04
# For ubuntu 14.04, potentially useful for 16.04 as well:
# Add qgis repos to get latest QGIS, see https://www.qgis.org/en/site/forusers/alldownloads.html#debian-ubuntu/qgis.org
# use the one with ubuntugis dependencies > http://qgis.org/ubuntugis/

RUN apt-get update \
    && apt-get install -qqy software-properties-common --no-install-recommends \
    && apt-add-repository -y ppa:ubuntugis/ubuntugis-unstable \ 
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 314DF160 \
    && apt-get -qqy update \
    && apt-get install -qqy --no-install-recommends --fix-missing \
        tree \
        xvfb \
        # QGIS requirements:
        gdal-bin \
        otb-bin \
        otb-bin-qt \
        python-otb \
        python-qgis-common \
        python-qgis \
        #saga \
        grass \
        # Python numerical and imaging libs:
        python-dev \
        python-scipy \
        python-numpy \
        # QGIS:
        qgis-plugin-grass \
        qgis-providers \
        qgis \
        # Needed to compile SAGA:
        wget \
        g++ \
        make \
        automake \
        libtool \
        libwxgtk3.0-dev \
        libtiff5-dev \
        libtiff4-dev \
        libgdal-dev \
        libproj-dev \
        libjasper-dev \
        libexpat1-dev \
        wx-common \
        libogdi3.2-dev \
        unixodbc-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install SAGA in specific version to avoid compatibility issues: http://hub.qgis.org/issues/13279
# A manualy try using software-properties-common and devscripts (rmadison) from different source packages/repos shows many different versions, but explicitly installing 2.2.0+dfsg-1build2 or 2.1.4+dfsg-1ubuntu1 does NOT work
# Instructions based on https://sourceforge.net/p/saga-gis/wiki/Compiling%20a%20Linux%20Unicode%20version/
WORKDIR /tmp
ENV SAGA_VERSION_MINOR 2.2.0
ENV SAGA_VERSION 2.2
#RUN wget http://downloads.sourceforge.net/project/saga-gis/SAGA%20-%20$SAGA_VERSION/SAGA%20$SAGA_VERSION_MINOR/saga_$SAGA_VERSION_MINOR.tar.gz \
#    && tar -xzf saga*.tar.gz \
#    && rm saga*.tar.gz \
#    && cd saga-$SAGA_VERSION_MINOR \
#    && ./configure \
#    && cd .. \
#    && make -C saga-$SAGA_VERSION_MINOR \
#    && make -C saga-$SAGA_VERSION_MINOR install \
#    && rm -r saga-$SAGA_VERSION_MINOR

# Set environment variables
ENV PYTHONPATH=/usr/share/qgis/python:/usr/lib/otb/python:/usr/share/qgis/python/plugins
