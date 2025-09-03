planets_packages:
	flutter pub get

planets_build:
	dart run build_runner build --delete-conflicting-outputs

planets_slang:
	dart run slang

planets_ui_gen:
	fluttergen -c pubspec.yaml


    