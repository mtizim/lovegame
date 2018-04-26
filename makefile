dev:
		sudo luarocks install inspect

makelove:
		rm -r pak/
		mkdir -p pak/
		mkdir -p pak/dependencies
		cp -r dependencies/* pak/dependencies/
		cp *.lua pak/
		cd pak/ ; \
		zip -9 -r $(shell pwd)/game.love .

apk:
		@echo "TpODO make this build the app"