#!/bin/bash
###mv /tmp/my.cnf {{ mysql_datadir }}my.cnf
chown -R {{ mysql_user }}:{{ mysql_user }} {{ mysql_basedir }}
###init mysql db###"
{{ mysql_basedir }}bin/mysqld --initialize --user=mysql --basedir={{ mysql_basedir }} --datadir={{ mysql_datadir }} &
#{{ mysql_basedir }}scripts/mysql_install_db --defaults-file={{ mysql_datadir }}my.cnf --basedir={{ mysql_basedir }} --datadir={{ mysql_datadir }} --user={{ mysql_user }} >> /dev/null 2>&1 &
sleep 1
mv /tmp/my.cnf /etc/my.cnf
cp {{ mysql_basedir }}support-files/mysql.server /etc/rc.d/init.d/mysqld

/etc/init.d/mysqld start
#/etc/init.d/mysqld start &
rm -rf /usr/bin/mysql /usr/bin/mysql_config
cat <<'TEST'
PATH = $PATH:/usr/local/mysql/bin
export PATH
TEST
>> /etc/rc.d/rc.local

source /etc/profile

#ln -s {{ mysql_basedir }}bin/mysql /usr/bin/mysql
#ln -s {{ mysql_basedir }}bin/mysql_config /usr/bin/mysql_config
#ln -s {{ mysql_sock }} /tmp/mysql.sock
echo "{{ mysql_basedir }}lib/" >>/etc/ld.so.conf
/sbin/ldconfig
chkconfig --add mysqld
#rm -rf /tmp/$(basename $0)
