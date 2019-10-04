# Introduction: containerized bitcoin core built from source.

Spin a container out of the image and use bitcoin core from the command line inside the virtual machine. Once started, the server automatically downloads the blockchain. Make it persistent by mounting an external volume to `/root/.bitcoin`.

A `bitcoin.conf.template` configuration template file is available in the repo. Name it `bitcoin.conf` on the persistent drive for `bitcoind` to use it.

# Build the image

You can pull the image from the docker hub: `docker pull florentdufour/bitcoin`. Otherwise, you can build it yourself.

## Default build

Clone the git repository and `cd` into it, then:

```shell
~$ docker build -t bitcoin:0.18.1 .
```

* Will build the docker image with Ubunt 18.04 and bitcoin core 0.18.1.
* Expect 25 to 30 min to build.

## Custom build

Pieces of the docker image can be built with different versions. Use the `--build-arg` flag during the build process.

### Versions

| Software    | Default version      | --build-arg       |
|-------------|----------------------|-------------------|
| Ubuntu      | 18.04                | ubuntuVersion     |
| Bitcoin     | 0.18.1               | bitcoinVersion    |
| Berkeley DB | db-4.8.30.NC         | berkeleydbVersion |

### Exemple

```shell
~$ docker build --build-arg bitcoinVersion=0.13.1 --build-arg ubuntuVersion=16.04 -t bitcoind:0.13.1 .
```

# Advice

* Building bitcoin from source is resource hungry. Allocate at least 2GB of RAM in Docker settings.
