#!/bin/bash

#NOT TESTED
sudo apt-get purge -y v4l2loopback-dkms
wait
sudo apt-get purge -y v4l-utils
wait
sudo apt purge -y ffmpeg
