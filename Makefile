build: boinc

boinc: Dockerfile
	docker build -f $< --rm -t $@ .

clean:
	docker-compose rm -f
	docker rmi -f boinc

machine:
	docker-machine create -d virtualbox \
		--virtualbox-no-share \
		--virtualbox-disk-size 50000 \
		--virtualbox-hostonly-cidr 192.168.59.1/24 \
		boinc

run:
	docker-compose up -d

stop:
	docker-compose stop
