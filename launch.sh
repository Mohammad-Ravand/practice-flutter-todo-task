#for running the application 
flutter run -d emulator-5554 --android-skip-build-dependency-validation

# for running the emulator
flutter emulators --launch Pixel_9


#solve problem hot reload and restart
Remove-Item Env:http_proxy -ErrorAction SilentlyContinue
Remove-Item Env:HTTP_PROXY -ErrorAction SilentlyContinue
Remove-Item Env:https_proxy -ErrorAction SilentlyContinue
Remove-Item Env:HTTPS_PROXY -ErrorAction SilentlyContinue

code "C:\Users\LIKEshop\Desktop\flutter-offline\my_project\my_project"

# for realease apk
flutter build apk --debug --android-skip-build-dependency-validation