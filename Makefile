pull:
	ansible-playbook -i ansible/inventory deploy.yml

up-media:
	cd /srv/docker/media && docker compose up -d

down-media:
	cd /srv/docker/media && docker compose down