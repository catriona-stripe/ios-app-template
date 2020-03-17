1.1.0-b1

See https://stripe.com/docs/terminal/sdk/ios-verifone-p400 for details about how this version is distributed.

## Changes

* Added beta support for Verifone P400 readers. See https://stripe.com/docs/terminal/sdk/ios-verifone-p400 for more details.
* Removed entries in `SCPDeprecations.h` from pre v1.0 beta releases. If you still need to update your app from a beta release, we recommend updating using v1.0.0 *first*, and then updating to the latest.
* Added `-[SCPTerminal collectPaymentMethod:delegate:completion:]` to the list of calls that can fail with `SCPErrorSessionExpired`, only while connected to `SCPDeviceTypeVerifoneP400` readers.
