#!/usr/bin/env bash

bash pi.sh 100 &
sudo nice -n -20 ./pi.sh 100 &
