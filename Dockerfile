FROM wangxian/alpine-mysql:latest

RUN echo $'[mysqld] \n\
user = root \n\
datadir = /app/mysql \n\
port = 3306 \n\
bind-address = 0.0.0.0 \n\
max_allowed_packet=1024M \n\
lower_case_table_names=1 \n\
max_connections=1000 \n\
innodb_file_per_table=OFF \n\
character_set_server=utf8 \n\
log-bin = /app/mysql/mysql-bin' > /etc/mysql/my.cnf && sed -i  's|FLUSH PRIVILEGES;|FLUSH PRIVILEGES;\n\
create database fin_dd_default;\n\
create user findd@localhost identified by "findd";\n\
create user findd@"%" identified by "findd";\n\
grant all on fin_dd_default.* to findd@localhost;\n\
grant all on fin_dd_default.* to findd@"%";|g'  /startup.sh

CMD ["/startup.sh"]