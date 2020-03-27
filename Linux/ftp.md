# ftp in Ubuntu16

### ftp command
* upload files  
put <filename>
* download files  
get <filename>
* change transfer mode  
>ftp> binary  
200 Type set to I


###
ftp $HOST
>ftp ftp.nj.hansight.work
~~~
Connected to ftp.nj.hansight.work.
220-FileZilla Server 0.9.58 beta
220-written by Tim Kosse (tim.kosse@filezilla-project.org)
220 Please visit https://filezilla-project.org/
Name (ftp.nj.hansight.work:ti): security
331 Password required for security
Password:
230 Logged on
Remote system type is UNIX.
ftp> cd ti
250 CWD successful. "/ti" is current directory.
ftp> help binary
binary    	set binary transfer type
ftp> ls
200 Port command successful
150 Opening data channel for directory listing of "/ti"
-rw-r--r-- 1 ftp ftp      213415314 Dec 05 18:16 enrich.zip
-rw-r--r-- 1 ftp ftp             16 Dec 05 10:53 hello.txt
-rw-r--r-- 1 ftp ftp      621325944 Dec 05 18:22 ioc.zip
226 Successfully transferred "/ti"
ftp> put enrich.zip
local: enrich.zip remote: enrich.zip
200 Port command successful
150 Opening data channel for file upload to server of "/ti/enrich.zip"
local: enrich.zip remote: enrich.zip
200 Port command successful
150 Opening data channel for file upload to server of "/ti/enrich.zip"
226 Successfully transferred "/ti/enrich.zip"
214251873 bytes sent in 102.38 secs (1.9958 MB/s)
ftp> cd ti
250 CWD successful. "/ti" is current directory.
ftp> ls
200 Port command successful
150 Opening data channel for directory listing of "/ti"
-rw-r--r-- 1 ftp ftp      214251873 Dec 05 18:25 enrich.zip
-rw-r--r-- 1 ftp ftp             16 Dec 05 10:53 hello.txt
-rw-r--r-- 1 ftp ftp      621325944 Dec 05 18:22 ioc.zip
226 Successfully transferred "/ti"
~~~
