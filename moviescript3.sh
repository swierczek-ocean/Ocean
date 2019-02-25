#!/bin/bash


for i in *.avi
do ffmpeg -i "$i" -c:v libx264 -preset veryslow -crf 18 ${i%.*}.mp4;
done
