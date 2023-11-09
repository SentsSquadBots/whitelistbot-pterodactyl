FROM        python:3.8-slim

LABEL       author="Sentennial" maintainer="email@sentennial.dev"

RUN         apt update \
            && apt -y install git wget curl nano tini \
            && useradd -m -d /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

STOPSIGNAL  SIGINT
RUN         wget https://raw.githubusercontent.com/SentsSquadBots/sentswhitelistbot/main/requirements.txt
RUN         pip install -r requirements.txt
RUN         wget https://raw.githubusercontent.com/SentsSquadBots/sentswhitelistbot/main/src/whitelistbot.py -P /home/co>

COPY        --chown=container:container ./entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh

ENTRYPOINT  ["/usr/bin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]
