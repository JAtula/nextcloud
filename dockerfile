FROM ubuntu:14.04
MAINTAINER Juhani Atula

# Install packages
RUN apt-get -qq update && apt-get -qq install -y apache2 libapache2-mod-php5 \
php5-gd php5-json php5-mysql php5-curl \
php5-intl php5-mcrypt php5-imagick wget unzip

# Set workdir
WORKDIR /tmp
RUN wget -q https://download.nextcloud.com/server/releases/nextcloud-9.0.53.zip 

#Copy various files
COPY perm.sh perm.sh

RUN unzip -q nextcloud-9.0.53.zip \
&& cp -r nextcloud /var/www/nextcloud \
&& chown -R www-data:www-data /var/www/nextcloud
COPY nextcloud.conf /etc/apache2/sites-available/nextcloud.conf

RUN a2enmod rewrite \
headers \
env \
dir \
mime \
&& a2ensite nextcloud.conf \
&& service apache2 restart

#Set permissions and run Apache
EXPOSE 80
COPY apache2-foreground /usr/local/bin/
RUN /bin/bash perm.sh \
&& chmod +x /usr/local/bin/apache2-foreground
CMD ["apache2-foreground"]