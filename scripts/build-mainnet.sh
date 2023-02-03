#!/bin/bash

NODE_TAG="v2023.01";
TONCENTER_TAG="1a0d48d";

pushd ../ &&
	sudo docker build -f ton-compile-source/Dockerfile -t ton-base-mainnet ton-compile-source/. --build-arg is_testnet=false --build-arg repo=https://github.com/ton-blockchain/ton.git --build-arg tag=$NODE_TAG &&
	sudo docker build -f ton-full-node/Dockerfile -t ton-node-mainnet ton-full-node/. --build-arg base=ton-base-mainnet &&
	sudo docker build -f ton-http-config/Dockerfile -t ton-http-config ton-http-config/. --build-arg base=ton-base-mainnet &&
	sudo docker build -f ton-toncenter/Dockerfile -t ton-toncenter-mainnet ton-toncenter/. --build-arg base=ton-base-mainnet --build-arg tag=$TONCENTER_TAG 
sudo docker tag ton-node-mainnet:latest jaybb/ton-blockchain:mainnet-node-$NODE_TAG
sudo docker tag ton-toncenter-mainnet:latest jaybb/ton-blockchain:mainnet-toncenter-$TONCENTER_TAG
sudo docker push jaybb/ton-blockchain -a
popd;

