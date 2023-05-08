IMAGE := ghcr.io/fopina/fluent-bit-plugin-dev:dev
TEST_IMAGE := fluent/fluent-bit:1.9.10

dev:
	docker build \
       	   -t $(IMAGE) \
           .

test-plugin:
	git clone https://github.com/fluent/fluent-bit-plugin test-plugin
	# why is this not merged...?
	cd test-plugin && git fetch https://github.com/nokute78/fluent-bit-plugin support_flb_v2 && git merge FETCH_HEAD

build-test-plugin: dev test-plugin
	docker run --rm -ti \
           -v $(PWD)/test-plugin:/myplugin \
           $(IMAGE) \
           cmake \
		   -DFLB_SOURCE=/usr/src/fluentbit/fluent-bit/ \
		   -DPLUGIN_NAME=out_stdout2 \
		   ../
	docker run --rm -ti \
           -v $(PWD)/test-plugin:/myplugin \
           $(IMAGE) \
           make

test: build-test-plugin
	docker run --rm -v $(PWD)/test-plugin:/myplugin \
           $(TEST_IMAGE) \
           /fluent-bit/bin/fluent-bit \
           -e /myplugin/flb-out_stdout2.so -i dummy -o stdout2
