FROM debian:jessie
MAINTAINER Jivan Kulkarni <jivank@gmail.com>

RUN echo deb http://www.lesbonscomptes.com/recoll/debian/ unstable main > \
	/etc/apt/sources.list.d/recoll.list

RUN echo deb-src http://www.lesbonscomptes.com/recoll/debian/ unstable main >> \
	/etc/apt/sources.list.d/recoll.list

RUN apt-get update && \
    apt-get install -y --force-yes recoll python-recoll python git wv poppler-utils && \
    apt-get clean
    
RUN apt-get install -y --force-yes unzip xsltproc unrtf untex libimage-exiftool-perl antiword pstotext 

RUN mkdir /data && mkdir /root/.recoll && mkdir /home/root
RUN echo topdirs = /data >> /root/.recoll/recoll.conf

RUN git clone https://github.com/koniu/recoll-webui.git
ADD start.sh /home/root/

VOLUME /data
EXPOSE 8080

RUN chmod +x /home/root/start.sh
CMD ["/home/root/start.sh"]
