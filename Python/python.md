# python install
### os ubuntu
> sudo apt-get update  
sudo apt-get install python2.7  
echo 'alias python=/usr/bin/python2.7' >> ~/.bashrc  
source !/.bashrc

### install python from source
download source files and extract
> wget https://www.python.org/ftp/python/3.5.1/Python-3.5.1.tgz  
tar xf Python-3.5.1.tgz

Building python
> cd Python3.5.1  
./configure  
make  
make test  
sudo make install  

### install virtualenv from source
get source file and extract
> wget https://pypi.python.org/packages/d4/0c/9840c08189e030873387a73b90ada981885010dd9aea134d6de30cd24cb8/virtualenv-15.1.0.tar.gz#md5=44e19f4134906fe2d75124427dc9b716  
tar -xzf virtualenv-15.1.0.tar.gz

install, use sudo if permission denied
> cd virtualenv-15.1.0
python setup.py install

# pip
pip install
> wget https://bootstrap.pypa.io/get-pip.py  
sudo python get-pip.py

pip upgrade
> sudo pip install --upgrade pip

pip install at specific folder
> pip install --target=d:\somewhere\other\than\the\default package_name

pip install specific version
> pip install GeoIP==1.3.2

# virtualenv
install

create virtual env
> virtualenv --no-site-packages .venv  # do not import system python env

active virtual env
> source .venv/bin/activate

make requirements.txt
> pip freeze > requirements.txt

download packages to local dir
> pip install -r requirements.txt -d your_download_dir

install packages from local dir
> pip install -r requirements.txt --no-index --find-links=file://your_download_dir

quit virtual env
> deactivate

# supervisor
install, [tutorial 1](http://www.restran.net/2015/10/04/supervisord-tutorial/)
[tutorial 2](http://liyangliang.me/posts/2015/06/using-supervisor/)
> pip install supervisor

cat default config files
> echo_supervisord_conf > /etc/supervisor.conf  

if permission denied, try:
> sudo su - root -c "echo_supervisord_conf > /etc/supervisord.conf"

run supervisor, if not use '-c', supervisor will find config file in $CWD/supervisord.conf,$CWD/etc/supervisord.conf,/etc/supervisord.conf by order :
> supervisord -c /etc/supervisord.conf

new program.ini need reloading before use:
> supervisorctl reload

# scrapy
install on ubuntu16.04LTS
> * [tutorial link](http://stackoverflow.com/questions/37669290/how-to-install-scrapy-on-unbuntu-16-04)

# inf and NaN in python
> inf is infinity - a value that is greater than any other value.  
-inf is therefore smaller than any other value.  
nan stands for Not A Number, and this is not equal to 0.
