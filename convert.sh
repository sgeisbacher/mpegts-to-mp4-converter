#!/bin/bash

HandBrakeCLI -i ${1} -o ${2} --preset="High Profile"
