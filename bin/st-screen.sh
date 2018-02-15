#!/bin/bash
st -e bash -c "screen $1 $2"
pkill screen
