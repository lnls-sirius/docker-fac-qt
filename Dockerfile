FROM lnls/fac-python

RUN apt-get update && \
	apt-get install -y sudo checkinstall libreadline-gplv2-dev \
		libncursesw5-dev libssl-dev libsqlite3-dev tk-dev \
        libgdbm-dev libc6-dev libbz2-dev swig liblapack-dev \
        libdbus-1-3 libglu1-mesa-dev && \
	rm -rf /var/lib/apt/lists/*

COPY qt-noninteractive.qs /qt-noninteractive.qs

ADD https://sourceforge.net/projects/pyqt/files/sip/sip-4.19.13/sip-4.19.13.tar.gz \
    https://sourceforge.net/projects/pyqt/files/PyQt5/PyQt-5.11.2/PyQt5_gpl-5.11.2.tar.gz \
    http://download.qt.io/official_releases/qt/5.11/5.11.2/qt-opensource-linux-x64-5.11.2.run ./

RUN chmod +x qt-opensource-linux-x64-5.11.2.run
RUN /qt-opensource-linux-x64-5.11.2.run --script qt-noninteractive.qs -platform minimal --verbose

RUN tar -xvf sip-4.19.13.tar.gz && \
    cd /sip-4.19.13 && \
    python3.6 configure.py --sip-module=PyQt5.sip && \
	make -j32 && \
    make install

RUN mkdir /opt/qt/5.11.2/gcc_64/plugins/PyQt5 && \
    tar xzf PyQt5_gpl-5.11.2.tar.gz && \
    cd /PyQt5_gpl-5.11.2 && \
	python3.6 configure.py --qmake=/opt/qt/5.11.2/gcc_64/bin/qmake \
                       	   --sip-incdir=/usr/local/include/python3.6m \
                           --designer-plugindir=/opt/qt/5.11.2/gcc_64/plugins/designer \
                           --qml-plugindir=/opt/qt/5.11.2/gcc_64/plugins/PyQt5 \
                           --confirm-license \
                           --assume-shared \
		                   --verbose && \
	make -j32 && \
	make install

RUN rm -r sip-4.19.13 PyQt5_gpl-5.11.2 qt-opensource-linux-x64-5.11.2.run Python-3.6.1.tgz
