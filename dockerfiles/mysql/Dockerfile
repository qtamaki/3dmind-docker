FROM ubuntu:latest

  ENV DEBIAN_FRONTEND noninteractive
  RUN apt-get update
  
  RUN apt-get install -y --no-install-recommends build-essential curl git
  RUN apt-get install -y --no-install-recommends mysql-server && service mysql stop
  RUN apt-get clean

  RUN service mysql start && echo "grant all on *.* to root;grant GRANT OPTION on *.* to root;" | mysql -u root && service mysql stop

  VOLUME ["/var/lib/mysql", "/work/tools"]
  
  EXPOSE 3306
  
