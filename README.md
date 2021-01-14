# Erobot-App

Start date: 24 July, 2020

Welcome to Open Source Project.<br>
Erobot is designed to control Arduino robot via Bluetooth.<br>The app is developing using Flutter.
<br>
<img src="./assets/screenshots/5screen.png"><br><br>
Functions of the app are:<br>

* Farm Assistant : (IN PLANNING)
* Arduino Documents : Document of how to build robots.
* Login, Sign up on the app.
* Sender : Send string or character to Arduino via bluetooth.
* Ball Shooter : A controller to control ball shooter robot, servo, and speed.
* Arduino Car : A controller to control Arduino car and speed.
* IR Remote : Vitual IR Remote via Bluetooth.
* About Us : Information about Erobot team.

<br>
<img src="./assets/screenshots/4screen.png">
<p>Prototype and design here: <a href="https://www.figma.com/file/x1edWP3L1by9QWuI5EVUiP/E-Robot-App?node-id=0%3A1" title="Figma">Figma</a></p>
<br>
<img src="./assets/screenshots/2screen.png"><br>

Use `flutter run --release` to test it or<br>
Build release to test:<br>

```console
$flutter build apk --release && flutter install build/app/outputs/flutter-apk/app-release.apk
```
Or
```console
$flutter build apk --target-platform android-arm64 --split-per-abi && flutter install build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
```

<br>


 
 
 
