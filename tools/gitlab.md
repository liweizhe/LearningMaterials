# git global setup
### Git global setup
>git config --global user.name "liweizhe"  
git config --global user.email "weizhe_li@hansight.com"  

### Create a new repository
>git clone http://172.16.100.168:8080/liweizhe/test.git
cd test  
touch README.md  
git add README.md  
git commit -m "add README"  
git push -u origin master  

### Existing folder
>cd existing_folder  
git init  
git remote add origin  http://172.16.100.168:8080/liweizhe/test.git
git add .  
git commit  
git push -u origin master  

### Existing Git repository
>cd existing_repo  
git remote add origin  http://172.16.100.168:8080/liweizhe/test.git  
git push -u origin --all  
git push -u origin --tags  

### generate ssh key
if ssh key exists
> cat ~/.ssh/id_rsa.pub

if not, generate it:
> ssh-keygen -t rsa -C "weizhe_li@hansight.com" -b 4096

### safe merge:
> git checkout master  
git pull origin master  
git merge test  
git push origin master  

### ignore tracked files
> git rm --cached <file>

example
~~~
# in directory: /Users/lwz/GitHub/OwnCIF
git rm --cached --force test/__init__.py
~~~

### ignore local changes
If you want remove all local changes from your working copy, simply stash them:

git stash save --keep-index
If you don't need them anymore, you now can drop that stash:

git stash drop

### set remote url
[tutorial](https://help.github.com/articles/changing-a-remote-s-url/)  
~~~
LWZsMBP:TEST lwz$ git remote -v
origin	http:/172.16.100.168:8080/liweizhe/TEST.git (fetch)
origin	http:/172.16.100.168:8080/liweizhe/TEST.git (push)
LWZsMBP:TEST lwz$ git remote set-url origin http://172.16.100.168:8080/liweizhe/TEST
LWZsMBP:TEST lwz$ git remote -v
origin	http://172.16.100.168:8080/liweizhe/TEST (fetch)
origin	http://172.16.100.168:8080/liweizhe/TEST (push)
~~~


### Permanently authenticating with Git repositories
Run following command to enable credential caching.
~~~
$ git config credential.helper store
$ git push https://github.com/repo.git

Username for 'https://github.com': <USERNAME>
Password for 'https://USERNAME@github.com': <PASSWORD>
Use should also specify caching expire,

git config --global credential.helper 'cache --timeout 7200'

~~~
After enabling credential caching, it will be cached for 7200 seconds (2 hour).  
Note: Credential helper storing unencrypted password on local disk.


# Press enter to submit commands

> $ git init  
>>Initialized empty Git repository in /.git/  

>$ git status
~~~
# On branch master  
#  
# Initial commit  
#  
nothing to commit (create/copy files and use "git add" to track)
~~~



>$ git status
~~~
On branch master  
#  
# Initial commit  
#  
# Untracked files:  
#   (use "git add <file>..." to include in what will be committed)  
#  
#	octocat.txt  
nothing added to commit but untracked files present (use "git add" to track)
~~~


>$ git add octocat.txt  
>>Nice job, you've added octocat.txt to the Staging Area  

>$ git status  
~~~
# On branch master  
#  
# Initial commit  
#  
# Changes to be committed:  
#   (use "git rm --cached <file>..." to unstage)  
#  
#	new file:   octocat.txt  
#  
~~~

>$ git commit -m "Add cute octocat story"  
>>[master (root-commit) 20b5ccd] Add cute octocat story  
 1 file changed, 1 insertion(+)  
 create mode 100644 octocat.txt  

>$ git add '\*.txt'  
$ git commit -m 'Add all the octocat txt files'  
>>[master 3852b4d] Add all the octocat txt files
 4 files changed, 4 insertions(+)  
 create mode 100644 blue_octocat.txt  
 create mode 100644   octofamily/baby_octocat.txt  
 create mode 100644   octofamily/momma_octocat.txt  
 create mode 100644 red_octocat.txt  

>$ git log  
>>commit 3852b4db1634463d0bb4d267edb7b3f9cd02ace1  
Author: Try Git <try_git@github.com>  
Date:   Sat Oct 10 08:30:00 2020 -0500  
    Add all the octocat txt files  
commit b652edfd888cd3d5e7fcb857d0dabc5a0fcb5e28  
Author: Try Git <try_git@github.com>  
Date:   Sat Oct 10 08:30:00 2020 -0500  
    Added cute octocat story  

>$ git remote add origin >>https://github.com/try-git/try_git.git  

>$ git push -u origin master  
>>Branch master set up to track remote branch master from origin.  

>$ git pull origin master
