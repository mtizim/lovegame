APK_DIR=../apkbuilding
NAME=muygame

dev:
		sudo luarocks install inspect

makelove:
		rm -rf pak/
		rm -f game.love
		mkdir -p pak/
		mkdir -p pak/dependencies
		mkdir -p pak/game
		mkdir -p pak/menus
		mkdir -p pak/misc
		cp -r dependencies/* pak/dependencies/
		cp -r game/* pak/game/
		cp -r menus/* pak/menus/
		cp -r misc/* pak/misc/
		cp *.png pak/
		cp *.lua pak/
		cp *.otf pak/
		cd pak/ ; \
		zip -9 -r $(shell pwd)/game.love .
		rm -rd pak/

apk:	
		rm -rf ${APK_DIR}/love_decoded
		cd ${APK_DIR}/ ; \
			apktool d -fs -o love_decoded love-11.1-android.apk
		mkdir -p ${APK_DIR}/love_decoded/assets/
		mv ./game.love ${APK_DIR}/love_decoded/assets/
		# also move the icon later
		# @echo "Edit apktool.yml"
		cp -f  ${APK_DIR}/apktool.yml ${APK_DIR}/love_decoded/apktool.yml
		cp -f  ${APK_DIR}/AndroidManifest.xml ${APK_DIR}/love_decoded/AndroidManifest.xml

		#icons
		rm ${APK_DIR}/love_decoded/res/drawable-mdpi/love.png
		rm ${APK_DIR}/love_decoded/res/drawable-xxxhdpi/love.png
		rm ${APK_DIR}/love_decoded/res/drawable-hdpi/love.png
		rm ${APK_DIR}/love_decoded/res/drawable-xxhdpi/love.png
		rm ${APK_DIR}/love_decoded/res/drawable-xhdpi/love.png
		rm ${APK_DIR}/love_decoded/build/apk/res/drawable-mdpi/love.png
		rm ${APK_DIR}/love_decoded/build/apk/res/drawable-xxxhdpi/love.png
		rm ${APK_DIR}/love_decoded/build/apk/res/drawable-hdpi/love.png
		rm ${APK_DIR}/love_decoded/build/apk/res/drawable-xxhdpi/love.png
		rm ${APK_DIR}/love_decoded/build/apk/res/drawable-xhdpi/love.png

		cp icons/mdpi.png ${APK_DIR}/love_decoded/res/drawable-mdpi/love.png
		cp icons/hdpi.png ${APK_DIR}/love_decoded/res/drawable-xxxhdpi/love.png
		cp icons/xhdpi.png ${APK_DIR}/love_decoded/res/drawable-hdpi/love.png
		cp icons/xxhdpi.png ${APK_DIR}/love_decoded/res/drawable-xxhdpi/love.png
		cp icons/xxxhdpi.png ${APK_DIR}/love_decoded/res/drawable-xhdpi/love.png
		cp icons/mdpi.png ${APK_DIR}/love_decoded/build/apk/res/drawable-mdpi/love.png
		cp icons/hdpi.png ${APK_DIR}/love_decoded/build/apk/res/drawable-xxxhdpi/love.png
		cp icons/xhdpi.png ${APK_DIR}/love_decoded/build/apk/res/drawable-hdpi/love.png
		cp icons/xxhdpi.png ${APK_DIR}/love_decoded/build/apk/res/drawable-xxhdpi/love.png
		cp icons/xxxhdpi.png ${APK_DIR}/love_decoded/build/apk/res/drawable-xhdpi/love.png

		cd ${APK_DIR}/ ; \
			apktool b -o muygame.apk love_decoded
		#my alias is literally alias_name lmao
		cd ${APK_DIR}/ ; \
			jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore game.keystore ${NAME}.apk alias_name