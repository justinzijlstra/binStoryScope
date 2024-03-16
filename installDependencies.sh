#!/bin/bash
sudo apt-get -y install v4l2loopback-dkms
wait
sudo apt-get -y install v4l-utils
wait
sudo apt install ffmpeg