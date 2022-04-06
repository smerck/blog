
build: 
	docker build . --tag hugo-server 

dev-server:
	cd hugo; hugo server -D --config config.dev.toml
