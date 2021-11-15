# vysheng-telegram-cli


Original https://github.com/vysheng/tg.git into docker with dependencies

You can use it:
```
docker run -ti --rm -v /srv/telegram/creds:/root/.telegram-cli -v /tmp/sendvideo:/mnt:rw \
--name telegram-cli-sf kasumiru/vysheng-telegram-cli /bin/telegram-cli  \
-W -e 'send_video files /mnt/filename.mp4'
```
