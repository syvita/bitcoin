# Introduction

Containerized bitcoin core built from source: spin a container out of the image and use bitcoin core from the command line inside the virtual machine. Once started, the server automatically downloads the blockchain. Make it persistent by mounting an external volume to `/root/.bitcoin`.

A `bitcoin.conf.template` configuration template file is available in the repo. Name it `bitcoin.conf` on the persistent drive for `bitcoind` to use it.

Example:

```shell
~$ docker pull florentdufour/bitcoin:0.18.1
~$ docker run -it --rm -v e:/bitcoin:/root/.bitcoin florentdufour/bitcoin:0.18.1
```

# Build the image

You can pull the image from the docker hub: `docker pull florentdufour/bitcoin`. Otherwise, you can build it yourself.

## Default build

Clone the git repository and `cd` into it, then:

```shell
~$ docker build -t bitcoin:0.18.1 .
```

* Will build the docker image with Ubuntu 18.04 and bitcoin core 0.18.1 by default.
* Expect 25 to 30 min to build.

## Custom build

Use the `--build-arg` flag to tweak your build.

### Versions

| Software    | Default version      | --build-arg       |
|-------------|----------------------|-------------------|
| Ubuntu      | 18.04                | ubuntuVersion     |
| Bitcoin     | 0.18.1               | bitcoinVersion    |
| Berkeley DB | db-4.8.30.NC         | berkeleydbVersion |

### Example

```shell
~$ docker build --build-arg bitcoinVersion=0.13.1 --build-arg ubuntuVersion=16.04 -t bitcoind:0.13.1 .
```

# Advice

* Building bitcoin from source is resource hungry. Allocate at least 2GB of RAM in Docker settings.
