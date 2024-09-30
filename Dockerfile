FROM openjdk:8-alpine

RUN apk add --no-cache bash sed

WORKDIR /minecraft

ENV MODPACK_ID=111
ENV MODPACK_VERSION_ID=12411
ENV EXTRA_JVM_ARGS=

ADD https://api.modpacks.ch/public/modpack/$MODPACK_ID/$MODPACK_VERSION_ID/server/linux linux
RUN chmod +x linux

RUN ./linux $MODPACK_ID $MODPACK_VERSION_ID --auto --noscript --nojava

# Crashing on Apple Silicon. Luckily, we don't actually need this mod.
RUN rm mods/simple-rpc-1.12.2-3.1.1.jar

COPY eula.txt eula.txt
COPY server.properties /minecraft/server.properties
COPY mods/* mods/

COPY server_start.sh server_start.sh
RUN chmod +x server_start.sh
CMD ["./server_start.sh"]
