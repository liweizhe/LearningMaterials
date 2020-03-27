# stop/start services
### stop mysql services
##### MacPorts
>sudo launchctl unload -w /Library/LaunchDaemons/org.macports.mysql.plist
sudo launchctl load -w /Library/LaunchDaemons/org.macports.mysql.plist
Note: this is persistent after reboot.

##### Homebrew
>launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
##### Binary installer
>sudo /Library/StartupItems/MySQLCOM/MySQLCOM stop
sudo /Library/StartupItems/MySQLCOM/MySQLCOM start
sudo /Library/StartupItems/MySQLCOM/MySQLCOM restart
