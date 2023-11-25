# 💊 RVX Manager

RVX Manager based on Flutter.

## 🔽 Download

To download latest Manager, go [here](https://github.com/inotia00/revanced-manager/releases/latest) and install the provided APK file.

## 📝 Prerequisites

1. Android 8 or higher
2. Only compatible with ARMv8 devices

## 📃 Documentation
The documentation can be found [here](https://github.com/inotia00/revanced-documentation/wiki/Method-3.-Using-RVX-Manager-(Android)).

## 🔴 Issues

For suggestions and bug reports, open an issue [here](https://github.com/inotia00/ReVanced_Extended/issues/new/choose).

## 🛠️ Building Manager from source

1. Setup flutter environment for your [platform](https://docs.flutter.dev/get-started/install)
2. Clone the repository locally
3. Add your GitHub token in gradle.properties like [this](/docs/4_building.md)
4. Open the project in terminal
5. Run `flutter pub get` in terminal
6. Then `flutter packages pub run build_runner build --delete-conflicting-outputs` (Must be done on each git pull)
7. To build release APK run `flutter build apk`