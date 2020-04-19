# docker-fluent-bit-plugin-dev

Docker image with the setup to build and test fluent-bit plugins

Contains fluent-bit headers and all the build tools ready to compile a C plugin for fluent-bit

## Usage / Example

Bind your plugin directory to `/myplugin` directory inside the container as the default workdir is `/myplugin/build` (it will create the directory if it doesn't exist).

Building the official [fluent-bit plugin](https://github.com/fluent/fluent-bit-plugin) example:


```bash
git clone https://github.com/fluent/fluent-bit-plugin
cd fluent-bit-plugin
docker run --rm -ti -v $(pwd):/myplugin fopina/fluent-bit-plugin-dev cmake -DFLB_SOURCE=/usr/src/fluentbit/fluent-bit-1.4.2/ -DPLUGIN_NAME=out_stdout2 ../
docker run --rm -ti -v $(pwd):/myplugin fopina/fluent-bit-plugin-dev make
```

And `build/flb-out_stdout2.so` will be created. It can be quickly tested with fluent-bit official image:

```
docker run --rm -v $(pwd):/myplugin fluent/fluent-bit:1.4.2 /fluent-bit/bin/fluent-bit -e /myplugin/flb-out_stdout2.so -i dummy -o stdout2
```
