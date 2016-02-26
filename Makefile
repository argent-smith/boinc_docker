run:
	docker-compose up -d

stop:
	docker-compose stop

# optional
machine:
	docker-machine create -d virtualbox \
		--virtualbox-no-share \
		--virtualbox-disk-size 20000 \
		--virtualbox-memory 2048 \
		--virtualbox-hostonly-cidr 192.168.59.1/24 \
		boinc
