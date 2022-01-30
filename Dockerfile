
FROM debian:buster


RUN apt-get update && \
apt-get install -y git libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev  \
libevent-dev libjansson-dev libpython-dev make zlib1g-dev libgcrypt-dev && \
git clone --recursive https://github.com/vysheng/tg.git && \
cd tg && \
env CFLAGS="-Wno-cast-function-type" ./configure --disable-openssl && \
ln -s /tg/bin/telegram-cli /bin/ && \
make



CMD [ "/bin/sh", "-c", "telegram-cli" ]
