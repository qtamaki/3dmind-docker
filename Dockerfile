FROM ubuntu:latest

  ENV DEBIAN_FRONTEND noninteractive
  RUN apt-get update
  
  RUN apt-get install -y --no-install-recommends build-essential curl git
  RUN apt-get install -y --no-install-recommends zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev libmysqlclient-dev ruby-dev imagemagick libmagickcore-dev libmagickwand-dev subversion mysql-client libmysqlclient-dev
  RUN apt-get clean

  RUN git clone https://github.com/sstephenson/rbenv.git /.rbenv
  RUN git clone https://github.com/sstephenson/ruby-build.git /.rbenv/plugins/ruby-build
  RUN /.rbenv/plugins/ruby-build/install.sh
  ENV PATH /.rbenv/bin:$PATH
  RUN echo 'PATH=/.rbenv/bin:$PATH' >> /etc/profile.d/rbenv.sh
  RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh # or /etc/profile
  
  RUN RUBY_CONFIGURE_OPTS="--with-readline-dir=/usr --with-openssl-dir=/usr/bin --disable-install-rdoc" rbenv install 2.1.2
  RUN rbenv global 2.1.2
  RUN rbenv rehash
  
  RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
  RUN . /etc/profile && gem install mysql2 -v '0.3.11'
  RUN . /etc/profile && gem install bundler
  RUN . /etc/profile && gem install rmagick --no-rdoc --no-ri

  RUN mkdir -p /work/three-d-mind
  RUN mkdir -p /work/sql
  RUN cd /work && git clone https://github.com/qtamaki/three-d-mind.git
  RUN . /etc/profile && cd /work/three-d-mind && bundle install

  RUN cd /work && curl -O http://nodejs.org/dist/v0.10.31/node-v0.10.31-linux-x64.tar.gz && tar xvzf node-v0.10.31-linux-x64.tar.gz
  ENV PATH /work/node-v0.10.31-linux-x64/bin:$PATH
  RUN echo 'PATH=/work/node-v0.10.31-linux-x64/bin:$PATH' >> /etc/profile.d/node.sh
  RUN npm install typescript

  VOLUME ["/work/three-d-mind", "/work/tools"]
  
  EXPOSE 3000
  
