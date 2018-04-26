dependencies:
		sudo luarocks install hc
		sudo luarocks install 30log
		yes | sudo sudo add-apt-repository ppa:bartbes/love-stable
		sudo apt-get update
		yes | sudo apt install love=10.2ppa1
dev:
		sudo luarocks install inspect

pak: 
		mkdir -p pak/
		cp *.lua pak/
		@echo "Also copy dependencies (hc and 30log) into the pak folder"
makelove:
		cd pak/ || @echo "Run make pak" ; \
		zip -9 -r $(shell pwd)/pak.love .

apk:
		mkdir -p apk/
		cp *.lua apk/
		@echo "TODO make this build the app"