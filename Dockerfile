ARG FROM_TAG='latest'
FROM shokohsc/alpine-s6:${FROM_TAG:-latest}

# install packages
RUN \
 echo "**** install build packages ****" && \
 apk update && \
 apk add --no-cache \
	apache2-utils \
	logrotate \
	nginx && \
 echo "**** configure nginx ****" && \
 echo 'fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;' >> \
	/etc/nginx/fastcgi_params && \
 rm -f /etc/nginx/conf.d/default.conf && \
 echo "**** fix logrotate ****" && \
 sed -i "s#/var/log/messages {}.*# #g" /etc/logrotate.conf

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80
