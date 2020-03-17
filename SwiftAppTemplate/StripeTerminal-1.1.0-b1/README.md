# Stripe Terminal iOS SDK and the Verifone P400 private beta

Please refer to the [beta documentation](https://stripe.com/docs/terminal/ios-verifone-p400).

## Requirements
The Stripe Terminal iOS SDK is compatible with apps supporting iOS 9 and above.

## Try the example app
The iOS SDK includes an open-source example app, which you can use to familiarize yourself with the SDK and reader before starting your own integration.

To build the example app from source, you'll need to:

1. Navigate to the `Example` folder, and open `Example.xcodeproj`.
2. Navigate to our [example backend](https://github.com/stripe/example-terminal-backend) and click the button to deploy it on Heroku.
3. In `AppDelegate.swift`, set the URL of the Heroku app you just deployed.
3. Build and run the app. The SDK comes with a simple reader simulator, so you can get started without any physical hardware.

Note: the example app comes with the Stripe Terminal SDK pre-installed, but uses a few other dependencies. We've included pre-built dependencies using Swift 4.2. You may need to run `./setup.sh` to re-build the app's dependencies for your environment.

## Installation
Please follow the [online instructions](https://stripe.com/docs/terminal/ios-verifone-p400#installing-sdk) for installation of this beta.

### Configure your app

Location services must be enabled in order to use the iOS SDK. Add the following key-value pair to your app's `Info.plist` file:

- Privacy - Location When In Use Usage Description
  - Key: `NSLocationWhenInUseUsageDescription`
  - Value: "Location access is required in order to accept payments."

> Note: Stripe needs to know where payments occur to reduce risks associated with those charges and to minimize disputes. If the SDK can’t determine the iOS device’s location, payments are disabled until location access is restored.

For your app to run in the background and remain connected to the reader, add this key-value pair to your `Info.plist` file:

- Required background modes
  - Key: `UIBackgroundModes`
  - Value: `bluetoooth-central` (Uses Bluetooth LE accessories) 
  - Note the value is actually an array that you will need to add `bluetooth-central` to.

For your app to pass validation when submitting to the App Store, add the following key-value pairs as well:

- Privacy - Bluetooth Peripheral Usage Description
  - Key: `NSBluetoothPeripheralUsageDescription`
  - Value: “Bluetooth access is required in order to connect to supported bluetooth card readers.”
- Privacy - Microphone Usage Description
  - Key: `NSMicrophoneUsageDescription`
  - Value: “Microphone access is required in order to connect to supported card readers.”

> Note: Although we do not currently support any audio-jack card readers, you'll still need to add a Microphone Usage Description to your Info.plist to pass App Store validation, as our underlying hardware SDK accesses these APIs. Since the SDK never actually uses microphone access, your users will never see a prompt for the microphone permission.


## Documentation
- [Getting Started](https://stripe.com/docs/terminal/ios)
- [API Reference](https://stripe.github.io/stripe-terminal-ios/docs/index.html)
- [Beta documentation](https://stripe.com/docs/terminal/ios-verifone-p400)
