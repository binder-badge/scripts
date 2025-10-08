#! /bin/bash
stacks_list=("list of stacks")
for ((i = 0; i < ${#stacks_list[@]}; i++))
do
    cd $HOME/${stacks_list[$i]}
    docker compose up -d
done
# sudo systemctl start frpc
curl "https://gotify.server/message?token=<token>" -F "title=Home Server started" -F "message=$(hostname) started up" -F "priority=5"
