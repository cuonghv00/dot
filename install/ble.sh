#!/bin/sh
dir=$(mktemp -d)

cleanup () {
    rm -rf "$dir"
}
trap cleanup EXIT

# check required packages
for pkg in git make gawk ;  do
    if [ -z "$(which $pkg)" ]; then
        echo "$pkg not installed"
        exit 1
    fi
done

# install ble.sh
url='https://github.com/akinomyoga/ble.sh.git'
cd $dir && git clone --recursive --depth 1 --shallow-submodules $url
make -C ble.sh install PREFIX=~/.local
chmod +x ~/.local/share/blesh/ble.sh
