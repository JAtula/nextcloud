FROM ubuntu:14.04
MAINTAINER Juhani Atula

# Install packages
RUN apt-get -qq update && apt-get -qq install -y apache2 libapache2-mod-php5 \
wget bzip2 php5-gd php5-json php5-mysql php5-curl \
php5-intl php5-mcrypt php5-imagick

# Set workdir
WORKDIR /workdir

#Untar tarball and copy conf-file
RUN wget -q https://download.nextcloud.com/server/daily/latest.tar.bz2 \
&& tar -xvjf latest.tar.bz2 -C /var/www \
&& chown -R www-data:www-data /var/www/nextcloud
COPY nextcloud.conf /etc/apache2/sites-available/nextcloud.conf

#Configure apache depencies
RUN a2enmod rewrite \
headers \
env \
dir \
mime \
&& a2dissite 000-default.conf \
&& a2ensite nextcloud.conf \
&& service apache2 restart

#Expose 80 and run Apache
EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]