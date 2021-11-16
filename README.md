# vysheng-telegram-cli


Original https://github.com/vysheng/tg.git into docker with dependencies

You can use it:
```
docker run -ti --rm -v /srv/telegram/creds:/root/.telegram-cli -v /tmp/sendvideo:/mnt:rw \
--name telegram-cli-sf kasumiru/vysheng-telegram-cli /bin/telegram-cli  \
-W -e 'send_video files /mnt/filename.mp4'
```

# or:
add in bashrc:
```# send to telegram throught docker
function sf(){
    f2s=${1}
    creds_dir="/srv/telegram/creds"
    base_shortname=$(basename "$f2s")
    shortname=`echo ${base_shortname} | sed 's/ /_/g'`
    shortname=$(echo $shortname | sed 's/ /_/g')
    sending_folder="/tmp/sendvideo"

    yes | rm "${sending_folder}/${f2s}" 2>/dev/null
    if [[ ! -d "${sending_folder}" ]]; then
        mkdir -p "${sending_folder}";
    fi

    if [[ ! -d "${creds_dir}" ]]; then
        mkdir -p "${creds_dir}"
        docker run -ti --rm \
        -v  ${creds_dir}:/root/.telegram-cli    \
        -v  ${sending_folder}:/mnt:rw           \
        kasumiru/vysheng-telegram-cli /bin/telegram-cli -W
    fi
    rsync -avP "${f2s}" "${sending_folder}/${shortname}";
    docker run -ti --rm -v \
        ${creds_dir}:/root/.telegram-cli -v \
        ${sending_folder}:/mnt:rw \
        --name telegram-cli-sf \
        kasumiru/vysheng-telegram-cli /bin/telegram-cli -W -e \
        "msg files ${base_shortname}:";

    docker run -ti --rm -v \
        ${creds_dir}:/root/.telegram-cli -v \
        ${sending_folder}:/mnt:rw \
        --name telegram-cli-sf \
        kasumiru/vysheng-telegram-cli /bin/telegram-cli -W -e \
        "send_video files /mnt/${shortname}";
    docker stop telegram-cli-sf 2>/dev/null
    docker rm telegram-cli-sf   2>/dev/null
    ls -l "${sending_folder}/${shortname}"
    yes | rm "${sending_folder}/${shortname}"
    }
```
and ```source ~/.bashrc```

now you can send file in your telegram group what named is "files" (create group "files", if not)
```
sf filename.mp4
```
NOTE: Press tab button then start shis first - telegram asked your phone number and auth code from telegram. 

