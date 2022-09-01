## install latest curl
sudo apt install libssl-dev autoconf libtool make
cd /tmp
wget https://curl.se/download/curl-7.85.0.tar.gz
tar -xzvf curl-7.85.0.tar.gz
cd curl-7.85.0
./configure --with-openssl
make
sudo make install
sudo ldconfig
