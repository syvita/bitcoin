# Introduction

> Bitcoin full node from docker, built from source, for amd and arm.

Use bitcoin core from the command line inside the container. Once started, the server automatically downloads the blockchain. Make it persistent by mounting an external volume to `/root/.bitcoin`.

A `bitcoin.conf.template` configuration template file is available in the repo. Name it `bitcoin.conf` on the persistent drive for `bitcoind` to use it.

# Build the image

You may prefer to build the image yourself.

## Default build

```shell
git clone https://github.com/syvita/bitcoin-core-docker.git
cd bitcoin-core-docker/
docker build -t bitcoin:0.21.1 .
```

* Will build the docker image with Ubuntu 20.04 and bitcoin core 0.21.1 by default.
* Expect 20 to 40 min to build depending on your configuration.

## Custom build

Use the `--build-arg` flag to tweak your build.

### Customization arguments

| Software    | Default version      | --build-arg       |
|-------------|----------------------|-------------------|
| Ubuntu      | 20.04                | ubuntuVersion     |
| Bitcoin     | v0.21.1              | bitcoinVersion    |
| Berkeley DB | db-4.8.30.NC         | berkeleydbVersion |

### Example of custom build

**Build**:

```shell
~$ docker build --build-arg bitcoinVersion=v0.13.1 --build-arg ubuntuVersion=16.04 -t yourname/bitcoin:0.13.1 .
```

**Launch**:

```shell
~$ docker run -it --rm -v /mnt/bitcoin:/root/.bitcoin yourname/bitcoin:0.13.1
```

# Use the image

- Bitcoin core is launched in daemon mode as the container is started
- It can run on the testnet or mainnet depending on you `bitcoin.conf` (regtest also possible)

## Commands

### bitcoin-cli

- All `bitcoind` and `bitcoin-cli` commands are available on start.
- Before stopping the container, use `bitcoin-cli stop` to write in memory blocks to the hard drive. Only once no bitcoin process is running should you stop the container. Use `top` to make sure that `bitcoind` is no longer running.

### Helper methods

You will find helper commands in `/root/.bashrc`:

- `log`: Will tail -f the log of bitcoind for the mainnet
- `logtest`: Will tail -f the log of bitcoind for the testnet

# Advice

* Building bitcoin from source is resource hungry. Allocate at least 2GB of RAM in Docker settings.
