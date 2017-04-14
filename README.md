# nextcloud

##Usage
[Install Docker] (https://docs.docker.com/engine/installation/)

1. **Download and start the Nextcloud server instance**
```
docker pull jatula/nextcloud:11.0.2
docker run --name nc -p 8080:80 -d jatula/nextcloud:11.0.2

```
2. **Access your Nextcloud server**

Point your web browser to http://localhost:8080
Note: If you're on MacOS or Windows you can't use "localhost" here. Run docker-machine ip default to figure out what you should use in place of localhost.

3. **Setup nextcloud**

Follow the instructions in your browser to perform the initial setup of your server.

4. **Stop the server instance**
```
docker stop nc
``` 
You can restart the container later with docker start nc

5. **Delete the server instance**
```
docker rm nc
```

##Build 

The image is clone of an official OwnCloud docker image configured to use NC links and resources. For example: 

```
# gpg key from https://owncloud.org/owncloud.asc
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys E3036906AD9F30807351FAC32D5D5E97F6978A26 \
	&& gpg --batch --verify owncloud.tar.bz2.asc owncloud.tar.bz2 \
	&& rm -r "$GNUPGHOME" owncloud.tar.bz2.asc \
	&& tar -xjf owncloud.tar.bz2 -C /usr/src/ \
	&& rm owncloud.tar.bz2
```
becomes this:
```
# gpg key from https://nextcloud.com/nextcloud.asc \
	&& wget https://nextcloud.com/nextcloud.asc \
	&& gpg --import nextcloud.asc \
	&& gpg --verify nextcloud.tar.bz2.asc nextcloud.tar.bz2 \
	&& rm -r "$GNUPGHOME" nextcloud.tar.bz2.asc \
	&& tar -xjf nextcloud.tar.bz2 -C /usr/src/ \
	&& rm nextcloud.tar.bz2
```
