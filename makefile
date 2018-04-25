dependencies:
		sudo luarocks install hc
		sudo luarocks install 30log
		yes | sudo sudo add-apt-repository ppa:bartbes/love-stable
		sudo apt-get update
		yes | sudo apt install love=11.1ppa1
dev:
		sudo luarocks install inspect

pack: 
		cp *.lua pak/
		@echo "Also copy dependencies (hc and 30log) into the pak folder"
		@echo "Remember to change color and opacity values from 0-1 to 0-255"
		@echo "Located in themes.lua and laser.lua"
makelove:
		cd pak/ ; \
		zip -9 -r $(shell pwd)/pak.love .
