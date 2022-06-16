#!/bin/sh

username = "user"
password = "pass"
hostname = "host"
mycnf = "/etc/mysql/my.cnf"
dt=$(date '+%d/%m/%Y %H:%M:%S');
audit_name = "SQL_Healthcheck_audit_report_"$dt

/bin/mysql -h $hostname -u $username  -p $password --skip-column-names -B -e "SHOW STATUS LIKE 'Queries'" > $audit_name

/bin/mysql -h $hostname -u $username  -p $password --skip-column-names -B -e "SHOW STATUS LIKE 'Table_open_cache_hits'" >> $audit_name

/bin/mysql -h $hostname -u $username  -p $password --skip-column-names -B -e "SHOW STATUS LIKE 'Ssl_session_cache_mode'" >> $audit_name

cat $mycnf | grep "innodb_buffer_pool_size" >> $audit_name

cat $mycnf | grep "ssl_key" >> $audit_name

ls -ltr $mycnf >> $audit_name