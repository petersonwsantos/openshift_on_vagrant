#!/bin/bash
PROMETHEUS_VERSION="2.2.1"
wget -q https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz
tar -xzvf prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz
cd prometheus-${PROMETHEUS_VERSION}.linux-amd64/

useradd --no-create-home --shell /bin/false prometheus 

mkdir -p /etc/prometheus
mkdir -p /var/lib/prometheus

chown prometheus:prometheus /etc/prometheus
chown prometheus:prometheus /var/lib/prometheus

cp -vfv prometheus /usr/local/bin/
cp -vfv promtool /usr/local/bin/

chown prometheus:prometheus /usr/local/bin/prometheus
chown prometheus:prometheus /usr/local/bin/promtool

cp -rfv consoles /etc/prometheus
cp -rfv console_libraries /etc/prometheus
cp -rfv prometheus.yml /etc/prometheus/prometheus.yml

chown -R prometheus:prometheus /etc/prometheus/consoles
chown -R prometheus:prometheus /etc/prometheus/console_libraries

echo '[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/prometheus.service

systemctl daemon-reload
systemctl enable prometheus
systemctl start prometheus


#install epel
yum -y install epel-release
yum install --enablerepo=epel python-pip -y 
sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo
pip install --upgrade pip
pip install --upgrade prometheus_client
rm prometheus-* -rfv