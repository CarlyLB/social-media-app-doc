#!/usr/bin/env bash

ffmpeg -i ./img/DemoScreencast.mov -pix_fmt rgb24 -filter:v "setpts=0.6*PTS" -b 64k ./img/DemoScreencast.gif