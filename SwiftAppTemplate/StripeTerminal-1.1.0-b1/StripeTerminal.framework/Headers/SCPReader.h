//
//  SCPReader.h
//  StripeTerminal
//
//  Created by Ben Guo on 8/1/17.
//  Copyright © 2017 Stripe. All rights reserved.
//
//  Use of this SDK is subject to the Stripe Terminal Terms:
//  https://stripe.com/terminal/legal
//

#import <Foundation/Foundation.h>

#import "SCPDeviceType.h"
#import "SCPJSONDecodable.h"
#import "SCPReaderNetworkStatus.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Information about a reader that has been discovered or connected to the SDK.
 Note some of the properties are specific to a certain device type and are
 labeled as such. If a property does not call out a specific device then it
 is applicable to all device types.
 */
NS_SWIFT_NAME(Reader)
@interface SCPReader : NSObject <SCPJSONDecodable>

/**
 The IP address of the reader. [VerifoneP400]
 */
@property (nonatomic, nullable, readonly) NSString *ipAddress;

/**
 The location ID of the reader. [VerifoneP400]
 @see https://stripe.com/docs/api/terminal/locations
 */
@property (nonatomic, nullable, readonly) NSString *locationId;

/**
 The networking status of the reader i.e. offline or online. Note that
 Chipper2x's status will be set to 'offline' because this is only relevant
 to VerifoneP400. [VerifoneP400]
 */
@property (nonatomic, readonly) SCPReaderNetworkStatus status;


/**
 A custom label that may be given to a reader for easier identification.
 [VerifoneP400]
 */
@property (nonatomic, nullable, readonly) NSString *label;

/**
 The reader's battery level, represented as a boxed float in the range `[0, 1]`.
 If the reader does not have a battery, or the battery level is unknown, this
 value is `nil`. [Chipper2x]
 */
@property (nonatomic, nullable, readonly) NSNumber *batteryLevel;

/**
 The stripe unique identifier for the reader.
 */
@property (nonatomic, nullable, readonly) NSString *stripeId;

/**
 The reader's device type.
 */
@property (nonatomic, readonly) SCPDeviceType deviceType;

/**
 True if this is a simulated reader.

 `SCPDiscoveryConfiguration` objects with `simulated = true` produce simulated
 Readers.
 */
@property (nonatomic, readonly) BOOL simulated;

/**
 The reader's serial number.
 */
@property (nonatomic, readonly) NSString *serialNumber;

/**
 The reader's current device software version, or `nil` if this information is
 unavailable.
 */
@property (nonatomic, nullable, readonly) NSString *deviceSoftwareVersion;

/**
 You cannot directly instantiate this class.
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 You cannot directly instantiate this class.
 */
- (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
