FROM handbrake-cli

ADD loadnconv_m3u8.sh /opt
ADD convert.sh /opt

RUN chmod u+x /opt/*.sh

WORKDIR /opt
