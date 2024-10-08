# Map Assignment

## Features:
1) **Location Input** : Users can input a location (city name, address, or coordinates) which is then displayed on the map with a marker.
2) **Current Location** : Users can retrieve and display their current location on the map.
3) **Map Type Toggle** : Users can switch between different map types (Normal, Satellite, Terrain) with the press of a button.
4) **Basic Validation** : Ensures that users provide a valid input before proceeding.
5) **Modular Code** : Project is structured with clean and modular code, ensuring easy maintenance and scalability.

## Prerequisites:
1. **Flutter SDK** : Ensure Flutter is installed and properly set up for iOS. Follow the [official setup guide](https://flutter.dev/docs/get-started/install/macos) if necessary.
2. **Xcode** : Make sure you have the latest version of Xcode installed on your macOS system.
3. **CocoaPods** : You need CocoaPods to manage iOS dependencies. Install it by running:
```bash
   sudo gem install cocoapods
```
4. **Google Maps API Key** : You need a Google Maps API key to use the google_maps_flutter package.




## iOS Setup Steps:
1. **Clone the Repository** \
Clone the project repository to your local machine.
```bash
git clone <repo-url>
cd <repo-directory>
```

2. **Set Up Google Maps API Key for iOS** : \
  a) Get an API Key: Obtain an API key from the Google Cloud Console.\
  b) Configure API Key: Open the ios/Runner/AppDelegate.swift file and add the following code:
``` swift
import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("Your API Key") //To DO
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```


## Input Screen

<div width="100%" align="start">
  <img src="https://github.com/user-attachments/assets/97e28270-d52c-44b5-924b-c1d2125efd36" width="20%"></img>
  &nbsp; 
  <img src="https://github.com/user-attachments/assets/1c9b8d2a-e71d-4cf8-9f9a-03add54ad1c1" width="20%"></img>
  &nbsp; 


## Map Screen

<div width="100%" align="start">
  <img src="https://github.com/user-attachments/assets/abfe2c03-1834-4554-89df-6f4024f2f6da" width="20%"></img>
  &nbsp; 
  <img src="https://github.com/user-attachments/assets/569ed1ed-3f4a-442b-9ac7-f7ea57ef42cb" width="20%"></img>
  &nbsp; 
  <img src="https://github.com/user-attachments/assets/1d1ab8a6-fe3e-494e-9925-b7a8a3d60b65" width="20%"></img>
  &nbsp;  
</div>
