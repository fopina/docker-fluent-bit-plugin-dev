dev: FLUENT_VERSION=1.9.2
dev:
	docker build \
       	   -t fopina/fluent-bit-plugin-dev:dev \
		   --build-arg FLUENT_VERSION=$(FLUENT_VERSION) \
           .