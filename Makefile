setup:
	flutter clean && flutter pub get && cd ios  && pod update && cd -

build_all:
	flutter clean && flutter pub get && cd ios  && pod update && cd .. && flutter build apk --release

build:
	flutter clean ; flutter pub get ; flutter build apk --release

xcode:
	open ios/Runner.xcworkspace

test:
	flutter test

format:
	dart format .
openIos:
	open ios/Runner.xcworkspace

runner:
	flutter pub run build_runner build --delete-conflicting-outputs

tr:
	dart run generate/strings/main.dart

fix:
	dart fix --apply
svg:
	dart run build_runner build

sha:
	keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

analyze_size: 
	flutter clean && flutter pub get && flutter build apk --analyze-size --target-platform android-arm64


