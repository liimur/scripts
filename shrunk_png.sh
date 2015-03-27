#!/bin/bash
PNGQUANT_HOME=~/pngquant
IMAGEOPTIM_HOME=~/ImageOptim
IMAGEOPTIM_CLI=ImageOptim-CLI-1.7.11/bin
IMAGEOPTIM_APP=/Applications/ImageOptim.app

if [ ! -d "$IMAGEOPTIM_APP" ]; then
        curl --output ~/ImageOptim.tbz2 \
                https://imageoptim.com/ImageOptim.tbz2
        cd ~/
        mkdir $IMAGEOPTIM_HOME
        mkdir $IMAGEOPTIM_HOME
        tar -C $IMAGEOPTIM_HOME -xvf ImageOptim.tbz2
        rm ImageOptim.tbz2
	mv $IMAGEOPTIM_HOME/ImageOptim.app /Applications
fi
if [ ! -d "$PNGQUANT_HOME" ]; then
	echo ***Installing PNGQuant
	curl --output ~/pngquant.tar.bz2 \
		http://pngquant.org/pngquant.tar.bz2
	mkdir $PNGQUANT_HOME
	tar -C $PNGQUANT_HOME -xvf ~/pngquant.tar.bz2
	rm ~/pngquant.tar.bz2
fi
if [ ! -d "$IMAGEOPTIM_HOME/$IMAGEOPTIM_CLI" ]; then
	echo ***Installing imageOptim
	mkdir $IMAGEOPTIM_HOME
	cd $IMAGEOPTIM_HOME
	curl --output $IMAGEOPTIM_HOME/imageoptim-cli.zip \
		https://codeload.github.com/JamieMason/ImageOptim-CLI/zip/1.7.11
	unzip -o $IMAGEOPTIM_HOME/imageoptim-cli.zip
	rm $IMAGEOPTIM_HOME/imageoptim-cli.zip
fi
export PATH=$PATH:$PNGQUANT_HOME:$IMAGEOPTIM_HOME/$IMAGEOPTIM_CLI

for input_file in "$@"
do
	pngquant --speed 1 --force --verbose --quality 60-80 "$input_file"
done
FIRST_FILE="$1"
FILES_DIR="${FIRST_FILE%/*}"
find "$FILES_DIR" -name '*-fs8.png' | sh $IMAGEOPTIM_HOME/$IMAGEOPTIM_CLI/imageOptim #
