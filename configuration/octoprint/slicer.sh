#!/bin/bash

echo ----
echo curl http://slicer.underdogma.net/slice --form "stl_file=@$4" --create-dirs -o $6
echo ----

curl http://slicer.underdogma.net/slice --form "stl_file=@$4" --create-dirs -o $6
