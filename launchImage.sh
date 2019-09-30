#!/usr/bin/bash

pathBlockchainPhysical="e:/bitcoin"
pathBlcokchainDocker="/root/.bitcoin"
pathDataPhysical="c:/Users/dufour"
pathDataDocker="/mnt/data"

docker run -it --rm \
	-v "$pathBlockhainPhysical:$pathBlockchainDocker" \
	-v "$pathDataPhysical:$pathDataDocker" \
	f-dufour/bitcoind:latest
