# Introduction

Containerized bitcoin core built from source. Run a full node from the command line inside the image. Once started, the server automatically downloads the blockchain. Make it persistent by mounting an external volume to `/root/.bitcoin`.

A `bitcoin.conf.template` configuration template file is available in the repo. Name it `bitcoin.conf` on the persistent drive for `bitcoind` to use it.

Example:

```shell
~$ docker pull florentdufour/bitcoin:0.19.0.1
~$ docker run -it --rm -v e:/bitcoin:/root/.bitcoin florentdufour/bitcoin:0.19.0.1
```

# Build the image

Instead of pulling the image from the hub, you can also build it yourself to suit your needs.

## Default build

```shell
~$ git clone https://github.com/f-dufour/bitcoin-core-docker.git
~$ cd bitcoin-core-docker/
~$ docker build -t bitcoin:0.19.0.1 .
```

* Will build the docker image with Ubuntu 18.04, bitcoin core 0.19.0.1, and Berekley 4.8.30.NC by default.
* Expect 25 to 30 min to build.

## Custom build

Use the `--build-arg` flag to tweak your build.

### Customization arguments

| Software    | Default version      | --build-arg       |
|-------------|----------------------|-------------------|
| Ubuntu      | 18.04                | ubuntuVersion     |
| Bitcoin     | v0.19.0.1            | bitcoinVersion    |
| Berkeley DB | db-4.8.30.NC         | berkeleydbVersion |

### Example of custom build

Build:

```shell
~$ docker build --build-arg bitcoinVersion=v0.13.1 --build-arg ubuntuVersion=16.04 -t yourname/bitcoin:0.13.1 .
```

Launch:

```shell
~$ docker run -it --rm -v e:/bitcoin:/root/.bitcoin yourname/bitcoin:0.13.1
```

# Commands

## bitcoin-cli

All `bitcoind` and `bitcoin-cli` commands are available. `bitcoind` is launched on start in daemon mode.

Before stopping the image, use `bitcoin-cli stop` to write in memory date to the disk. Use `top` to make sure that `bitcoind` is no longer running.

## Helper methods

You find helper commands in `/root/.bashrc`:

- `log`: Will tail -f the log of bitcoind for the mainnet
- `logtest`: Will tail -f the log of bitcoind for the testnet

# Advice

* Building bitcoin from source is resource hungry. Allocate at least 2GB of RAM in Docker settings.
