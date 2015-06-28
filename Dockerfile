FROM centos:centos6

MAINTAINER tadyjp

ENV PATH $PATH:/usr/bin

# repository
RUN yum -y install wget

# system update
RUN yum -y update
RUN yum -y groupinstall "Development Tools"
RUN yum -y install gcc git tar openssl openssl-devel pcre pcre-devel

# rbenv
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN /root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> .bashrc

# ruby
ENV CONFIGURE_OPTS --disable-install-doc
RUN rbenv install 2.2.2
RUN rbenv global 2.2.2
RUN echo 'eval "install: --no-document"' >> .gemrc
RUN echo 'eval "update: --no-document"' >> .gemrc
RUN bash -lc 'gem install rake --force'

# nginx + mruby
RUN cd /usr/local/src/ && git clone https://github.com/matsumoto-r/ngx_mruby.git
ENV NGINX_CONFIG_OPT_ENV --with-http_stub_status_module --with-http_ssl_module --prefix=/usr/local/nginx --with-http_realip_module --with-http_addition_module --with-http_sub_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module
RUN cd /usr/local/src/ngx_mruby && bash -lc 'sh build.sh' && make install

# WIP:
# RUN echo "example docker contena nginx server" > /usr/share/nginx/html/index.html
COPY conf/nginx.conf /usr/local/nginx/conf/nginx.conf

# ENTRYPOINT /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf

# ENTRYPOINT while true; do sleep 3 && echo "sleep!" ; done
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]

EXPOSE 80

