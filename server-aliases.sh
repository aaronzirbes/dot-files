
# MySQL
#export MYSQL_HOME=/usr/local/mysql-5.1.63-osx10.6-x86_64
export MYSQL_HOME=/usr/local/mysql
export PATH="$PATH:$MYSQL_HOME/bin"
# Aliases - MySQL
alias mysqlstart="launchctl load -w $HOME/Library/LaunchAgents/com.mysql.mysqld.plist"
alias mysqlstop="launchctl unload -w $HOME/Library/LaunchAgents/com.mysql.mysqld.plist"
# Aliases - Reddis
alias redisstart='launchctl start homebrew.mxcl.redis'
alias redisstop='launchctl stop homebrew.mxcl.redis'
# Aliases - RabbitMQ
alias rabbitmqstart='launchctl start homebrew.mxcl.rabbitmq'
alias rabbitmqstop='launchctl stop homebrew.mxcl.rabbitmq'
