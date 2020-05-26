FROM debian:buster-slim
MAINTAINER dsheyp

RUN apt-get update

RUN apt-get install -y apt-transport-https ca-certificates gnupg-agent curl cron

RUN echo deb http://www.lesbonscomptes.com/recoll/debian/ buster main > \
	/etc/apt/sources.list.d/recoll.list

RUN echo deb-src http://www.lesbonscomptes.com/recoll/debian/ buster main >> \
	/etc/apt/sources.list.d/recoll.list

RUN curl -fsSL https://www.lesbonscomptes.com/pages/jf-at-dockes.org.pgp | apt-key add -

RUN apt-get update && \
    apt-get install -y recoll python3-recoll python3 python3-pip git wv poppler-utils && \
    apt-get clean
    
RUN apt-get install -y unzip xsltproc unrtf untex libimage-exiftool-perl antiword 

RUN mkdir /books && mkdir /root/.recoll

COPY recoll.conf /root/.recoll/recoll.conf

RUN git clone https://framagit.org/medoc92/recollwebui.git

RUN pip3 install waitress ujson

VOLUME /books

EXPOSE 8080

RUN recollindex

CMD ["/usr/bin/python3", "/recollwebui/webui-standalone.py", "-a", "0.0.0.0"]
