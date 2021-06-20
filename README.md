# Spotify Clone

A UIKit clone project of the Spotify app.

## Table of Content

- [Description](#description)
- [Tech/Frameworks Used](#techframework-used)
- [Installation](#installation)

## Description

A clone of the spotify application built using UIKit. The app consumes data from Spotify API and mimic the functionalities of the official Spotify App as much as possible with Haptic feedback.

![App Screen Shot](https://github.com/Ath3r/spotify-clone-ios/blob/master/demo/main.png)
_The main screen of the app_

![App Screen Shot](https://github.com/Ath3r/spotify-clone-ios/blob/master/demo/library.png)
_The Library screen of the app_

![App Screen Shot](https://github.com/Ath3r/spotify-clone-ios/blob/master/demo/albums.png)
_The Albums screen of the app_

![App Screen Shot](https://github.com/Ath3r/spotify-clone-ios/blob/master/demo/search.png)
_The search screen of the app_

## Tech/Framework Used

- UIKit (Swift)
- SDWebImage
- Appirater

## Installation

This project requires [Xcode](https://developer.apple.com/xcode/) and [CocoaPods](https://cocoapods.org/) installed globally.

Clone the repository to a directory of your choosing

```sh
 git clone https://github.com/Ath3r/spotify-clone-ios
```

Navigate into spotify-clone-ios and install the necessary packages

```sh
 pod install
```

Open the xcworkspace file created by the CocoaPods

Go to `/Managers/AuthManager.swift`

Update the ClientId, ClientSecret and redirectURI(Your website URL) which you can get it from [here](https://developer.spotify.com/dashboard/applications).
