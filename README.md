# React Native iOS Library
## react-native-ios-library-nsr

## Getting started iOS

### Installation

1. Do `npm install --save git+https://github.com/neosurance/react-native-ios-library-nsr.git` in your main project, or `yarn add git+https://github.com/neosurance/react-native-ios-library-nsr.git`


2. Do `react-native link react-native-ios-library-nsr` in your main project

#### XCode

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-ios-library-nsr` ➜ `ios` and add `RNReactNativeIosLibraryNsr.xcodeproj`
3. Go to `node_modules` ➜ `react-native-ios-library-nsr` ➜ `ios` and add `eventCruncher.html`
4. In XCode, in the project navigator, select your project. Add `libRNReactNativeIosLibraryNsr.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
5. Run your project (`Cmd+R`)<

### Requirements

1. Inside your **info.plist** be sure to have the following permissions:

	```plist
	<key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
        <key>NSExceptionDomains</key>
        <dict>
            <key>localhost</key>
            <dict>
                <key>NSExceptionAllowsInsecureHTTPLoads</key>
                <true/>
            </dict>
        </dict>
    </dict>
    <key>UIBackgroundModes</key>
    <array>
        <string>fetch</string>
        <string>location</string>
        <string>remote-notification</string>
    </array>
    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
    <string>Always and when in use...</string>
    <key>NSLocationAlwaysUsageDescription</key>
    <string>Always...</string>
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>When in use...</string>
    <key>NSMotionUsageDescription</key>
    <string>Motion...</string>
    <key>NSCameraUsageDescription</key>
    <string>for claim...</string>
	```

2. Be sure to have the following capabilities:

	```
	Targets -> Your App -> Capabilities -> Background Modes ON:
	  - Location updates (checked)
	  - Background fetch (checked)
	  - Remote Notifications (checked)
	```

### Usage
```javascript
import RNReactNativeIosLibraryNsr from 'react-native-ios-library-nsr';

...

var settings = {
        base_url:"https://...",
        code:"code",
        secret_key:"secret_key",
        dev_mode: true,
        disable_log:false
};

...

if(Platform.OS === 'ios') {

    var _self = this;

    RNReactNativeIosLibraryNsr.setup(JSON.stringify(settings),function(err, res){
        console.log(">>>> SETUP: " + res);
    });
    
}

```
