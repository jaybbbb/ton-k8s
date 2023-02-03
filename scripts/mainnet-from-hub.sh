#!/bin/bash

sudo docker pull jaybb/ton-blockchain:mainnet-node-v2023.01
sudo docker tag jaybb/ton-blockchain:mainnet-node-v2023.01 ton-node-mainnet:latest
sudo docker pull jaybb/ton-blockchain:mainnet-toncenter-1a0d48d
sudo docker tag jaybb/ton-blockchain:mainnet-toncenter-1a0d48d ton-toncenter-mainnet:latest

pushd ../composes
sudo docker compose -f mainnet.yaml up -d --force-recreate
popd;
