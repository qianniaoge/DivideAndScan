#!/usr/bin/env bash

# Nmap

apt install nmap sudo xsltproc -y
nmap --script-updatedb

# Masscan

cd /tmp
git clone https://github.com/robertdavidgraham/masscan.git
cd masscan
make
make install
cd && rm -rf /tmp/masscan

# RustScan

cd /tmp

wget -qO- https://api.github.com/repos/RustScan/RustScan/releases/latest \
| grep "browser_download_url.*amd64.deb" \
| cut -d: -f2,3 \
| tr -d \" \
| wget -qO rustscan.deb -i-

dpkg -i rustscan.deb
cd && rm /tmp/rustscan.deb

wget https://gist.github.com/snovvcrash/c7f8223cc27154555496a9cbb4650681/raw/a76a2c658370d8b823a8a38a860e4d88051b417e/rustscan-ports-top1000.toml -O /root/.rustscan.toml

# Naabu

mkdir /opt/projectdiscovery
cd /opt/projectdiscovery

wget -qO- https://api.github.com/repos/projectdiscovery/naabu/releases/latest \
| grep "browser_download_url.*linux-amd64.tar.gz" \
| cut -d: -f2,3 \
| tr -d \" \
| wget -qO naabu.tar.gz -i-

tar -xzf naabu.tar.gz
mv naabu-linux-amd64 naabu
rm naabu.tar.gz README.md LICENSE.md
ln -s /opt/projectdiscovery/naabu /usr/local/bin/naabu

# DivideAndScan

cd /app
pip3 install .
