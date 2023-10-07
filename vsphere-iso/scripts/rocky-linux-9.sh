#!/bin/sh

sudo dnf upgrade -y
sudo dnf autoremove -y
sudo dnf clean all
