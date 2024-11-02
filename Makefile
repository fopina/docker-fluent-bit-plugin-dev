IMAGE := ghcr.io/fopina/fluent-bit-plugin-dev:dev
TEST_VERSION := 3.1.9
TEST_IMAGE := fluent/fluent-bit:$(TEST_VERSION)

dev:
	docker build \
       	   -t $(IMAGE) \
           .

build-test-plugin: dev
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
           -e /myplugin/build/flb-out_stdout2.so -i dummy -o stdout2

update-plugin:
	curl https://github.com/fluent/fluent-bit/archive/refs/tags/v$(TEST_VERSION).zip -Lo plugin.zip
	unzip plugin.zip 'fluent-bit-$(TEST_VERSION)/plugins/out_stdout/*'
	rm plugin.zip
	rm -fr test-plugin/out_stdout2
	mv 'fluent-bit-$(TEST_VERSION)/plugins/out_stdout/' test-plugin/out_stdout2
	rm -fr 'fluent-bit-$(TEST_VERSION)'
	echo "===> out_stdout updated from upstream: REPLACE PLUGIN NAME in out_stdout2 CMakeLists and rename the struct in stdout.c - or build will fail"
