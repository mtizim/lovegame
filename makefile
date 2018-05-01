APK_DIR=../apkbuilding
NAME=muygame

dev:
		sudo luarocks install inspect

makelove:
		rm -rf pak/
		rm -f game.love
		mkdir -p pak/
		mkdir -p pak/dependencies
		cp -r dependencies/* pak/dependencies/
		cp *.lua pak/
		cp *.otf pak/
		cd pak/ ; \
		zip -9 -r $(shell pwd)/game.love .

apk:	
		rm -rf ${APK_DIR}/love_decoded
		#idk why but it needs to be removed #OR CAN BE LEFT LUL
		# rm ~/.local/share/apktool/framework/1.apk
		cd ${APK_DIR}/ ; \
			apktool d -fs -o love_decoded love-11.1-android.apk
		mkdir -p ${APK_DIR}/love_decoded/assets/
		mv ./game.love ${APK_DIR}/love_decoded/assets/
		# also move the icon later
		# @echo "Edit apktool.yml"
		cp -f  ${APK_DIR}/apktool.yml ${APK_DIR}/love_decoded/apktool.yml
		cp -f  ${APK_DIR}/AndroidManifest.xml ${APK_DIR}/love_decoded/AndroidManifest.xml
		cd ${APK_DIR}/ ; \
			apktool b -o muygame.apk love_decoded
		#my alias is literally alias_name lmao
		cd ${APK_DIR}/ ; \
			jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore game.keystore ${NAME}.apk alias_name