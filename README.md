# Cordova Banner Notifications
[![npm version](https://badge.fury.io/js/cordova-banner-notification.svg)](https://badge.fury.io/js/cordova-banner-notification) [![Build Status](https://travis-ci.org/DavidBriglio/cordova-banner-notification.svg?branch=master)](https://travis-ci.org/DavidBriglio/cordova-banner-notification)

This plugin was created to support showing banner notifications at the top of the application in cordova. This is meant for iOS to show notifications while the app is in the foreground. The notification structure is easy to use and able to support function callbacks on clicking the banner.

## Supported Features:
- Scrolling text
- Banner colour customization
- Text colour customization
- In/Out Animation customization
- Adding / removing onclick functions
- Duration customization
- Banner size: big + small

## Sample

Here is an example of the 'big' style banner notification:

<img src="https://github.com/DavidBriglio/cordova-banner-notification/blob/master/sample/LargeNotificationSample.png" width="50%"/>

```javascript
//Big Banner
cordova.plugins.notification.banner.show({
  message:"New Notification",
  //style: "big",
  backcolor:{
    //alpha: 255,
    red: 255,
    blue: 50
  }
});
```



Here is an example of the 'small' style banner notification:

<img src="https://github.com/DavidBriglio/cordova-banner-notification/blob/master/sample/SmallNotificationSample.png" width="50%"/>

```javascript
//Small Banner
cordova.plugins.notification.banner.show({
  message:"New Notification",
  style: "small",
  backcolor:{
    //alpha: 255,
    red: 255,
    blue: 50
  }
});
```



## Supported Platforms:
- iOS (Tested on iOS 9)

## Installation:
This plugin can be installed from CLI with either of the following:

```bash
cordova plugins add cordova-banner-notification
#or
cordova plugins add https://github.com/DavidBriglio/cordova-banner-notification
```

## Library Used
This plugin is a wrapper to the CWStatusBarNotification library created by [cezarywojcik](https://github.com/cezarywojcik):
https://github.com/cezarywojcik/CWStatusBarNotification

- The version used is a modified version of v2.3.4
- The animation effect of altering the view when the notification slides in/out has been removed

Please support their github!

## Questions?
Please see the wiki for how to use the plugin.

Feel free to send me a message, open an issue, or make pull requests!


## License

This software is released under the MIT License.

David Briglio 2016.
