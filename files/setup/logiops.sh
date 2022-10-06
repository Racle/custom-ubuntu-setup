#/bin/sh
#
# get current folder path
SCRIPT=$(readlink -f "$0")
DIR=$(dirname "$SCRIPT")

git clone https://github.com/PixlOne/logiops.git /tmp
cd /tmp/logiops/
mkdir build
cd build
cmake ..
make
sudo make install
cd -
rm /tmp/logiops -rf
sudo cp $DIR/../logid.cfg /etc/logid.cfg
sudo systemctl enable --now logid

