FROM openjdk:8-alpine

RUN apk add --no-cache wget bash unzip sed

RUN wget https://media.forgecdn.net/files/3565/687/SkyFactory-4_Server_4_2_4.zip

RUN mkdir -p /minecraft/ && unzip SkyFactory-4_Server_4_2_4.zip -d /minecraft/ && chmod +x /minecraft/Install.sh

RUN cd /minecraft/ && ./Install.sh
RUN chmod +x /minecraft/ServerStart.sh

ADD settings.sh /minecraft/settings.sh
ADD eula.txt /minecraft/eula.txt
ADD server.properties /minecraft/server.properties
ADD ops.json /minecraft/ops.json
ADD mods/* /minecraft/mods/
RUN sed -i -e 's/B:"Prestige Enabled Default"=false/B:"Prestige Enabled Default"=true/g' /minecraft/config/prestige.cfg && \
	sed -i -e 's/B:NewWorldMode=false/B:NewWorldMode=true/g' /minecraft/config/prestige.cfg


CMD cd /minecraft/ && ./ServerStart.sh