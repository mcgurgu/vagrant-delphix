#!/usr/bin/env bash

cd test

vagrant up
vagrant halt
vagrant destroy -f
