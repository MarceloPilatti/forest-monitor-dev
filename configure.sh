#!/bin/bash

sudo apt install -y python3.8-dev python3.8-venv python3-pip

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

nvm install 14
nvm use 14

cd ~/mydevel/

git clone -b develop -o upstream https://github.com/brazil-data-cube/forest-monitor.git

cd ~/mydevel/forest-monitor

pip3 install -r docker-base/requirements.txt

cd ~/mydevel/

git clone -b develop -o upstream https://github.com/brazil-data-cube/forest-monitor-app.git

cd ~/mydevel/forest-monitor-app/forest-monitor-app

npm install

echo -e "
alias forest-monitor-start=\"nvm use 14;cd ~/mydevel/forest-monitor-app/forest-monitor-app;./run-local.sh\"" >> ~/.bashrc

source ~/.bashrc
