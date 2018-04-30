#!/bin/sh

trap "shut_down" HUP INT QUIT KILL TERM

shut_down(){
  service mysqld stop
  service nginx stop
  service httpd stop
  service crond stop
}

/etc/init.d/bvat start

service mysqld stop
mysqld_safe --user=root --skip-grant-tables &
mysql -e "use mysql; repair table user, db, proxies_priv;"

service mysqld restart
service crond start
service httpd start
service nginx start

echo "[hit enter key to exit] or run 'docker stop <container>'"
read _

shut_down

echo "exited $0"
