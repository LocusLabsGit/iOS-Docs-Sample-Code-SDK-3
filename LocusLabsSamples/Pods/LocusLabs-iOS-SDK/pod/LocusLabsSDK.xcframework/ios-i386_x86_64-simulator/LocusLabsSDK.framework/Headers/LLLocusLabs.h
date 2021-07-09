//
//  LLLocusLabs.h
//  LocusLabsSDK
//
//  Created by Glenn Dierkes on 1/23/15.
//  Copyright © 2015-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLLocusLabsDelegate.h"
#import "LLPOICheckinDelegate.h"

@protocol GrabClientInterface;

@class LLPerson;

/**
 * This class is used for setting up the LocusLabs SDK.  It has a singleton instance which is accessed via the +(LLLocusLabs *)setup method.
 * Before any other SDK methods are called, the accountId property must be set.
 */
@interface LLLocusLabs : NSObject

/**
 * The delegate used to manage POI Checkins.
 */
@property (nonatomic, strong, nullable) id<LLPOICheckinDelegate> poiCheckinDelegate;

/**
 * The account id the SDK should use to interact with the LocusLabs resources.
 */
@property (nonatomic, copy, null_unspecified) NSString *accountId;

/**
 * Returns the Install ID, an identifier associated with server-side event logging for user analytics.
 *
 * Please note that installId depends on the currently set <code>accountId</code>.
 */
@property (nonatomic, readonly, nonnull) NSString *installId;

/**
 Sets a user property to a given value for analytics purposes. Up to 10 user property names are supported. Once set, user property values persist throughout the app lifecycle and across sessions.
 
 Before setting any properties the accountId has to be set.
 
 @warning the property cannot contain any personally identifiable information (PII).
 @warning setting property with no accountId set or setting the property that doesn't match some of the criteria will be ignored and logged as an error
 
 @param value The value of the user property. Values can be up to 128 characters long. Setting the value to nil removes the user property.
 @param name The name of the user property to set. Should contain 1 to 128 alphanumeric characters or underscores and must start with an alphabetic character.
 */
- (void)setAnalyticsUserPropertyString:(nullable NSString *)value
                               forName:(nonnull NSString *)name
NS_SWIFT_NAME(setAnalyticsUserProperty(_:forName:));

/**
 Clears all analytics user properties (equivalent of setting them all to nil)
 
 Before resetting the properties the accountId has to be set.
 @warning calling this property with no accountId set will be ignored and logged as an error
 */
- (void)resetAnalyticsUserProperties;

/**
 Checks if there are any analytics events stored locally that needs to be sent to the server side. This method is asynchronous and will call the callback with the result
 
 This method requires <code>accountId</code> to be set, otherwise it'll return an error.
 
 Please note that generally the app using LocusLabs library doesn't have to deal with sending analytics events, as they're being sent regularly.
 This method is exposed to be used in case when the application wants to schedule sending the events in case when it goes into background and needs a guarantee that analytics events will be delivered
 even if the application is not running.

 @param callback returns the results of the check. <code>anyAnalyticsEventsToSend</code> is <code>YES</code> if there are events waiting to be send, <code>NO</code> if there's no events in the local database. If the check couldn't be performed a non null <code>error</code> is returned.
 */
- (void)anyAnalyticsEventsToSend:(void (^_Nonnull)(BOOL anyAnalyticsEventsToSend, NSError * _Nullable error))callback;

/**
  Sends all analytics events stored locally and calls the callback when done or failed.
 
  This method requires <code>accountId</code> to be set, otherwise it'll return an error.
 
  Please note that generally the app using LocusLabs library doesn't have to deal with sending analytics events, as they're being sent regularly.
  This method is exposed to be used in case when the application wants to schedule sending the events in case when it goes into background and needs a guarantee that analytics events will be delivered
 even if the application is not running.
 
  @param callback If sending succeeded it's called with <code>nil</code> error value. otherwise a non null <code>error</code> is returned.
 */
- (void)sendAllAnalyticsEvents:(void (^_Nullable)(NSError * _Nullable error))callback;

/**
 * The user's IDFA for analytics tracking.
 *
 * **Deprecated:**: use <code>setAnalyticsUserPropertyString:forName:</code> instead
 */
@property (nonatomic, retain, nullable) NSUUID *idfa __attribute__((deprecated("use setAnalyticsUserPropertyString:forName: property instead")));

/**
 * Sets the LLLocusLabsDelegate
 */
@property (nonatomic, weak, nullable) id<LLLocusLabsDelegate> delegate;

/**
 * The Grab customer ID. If nil, Grab will not be loaded.
 */
@property (nonatomic, copy, nullable) NSString *grabCustomerId;

/**
 * Optional dictionary defining styles for Grab.
 */
@property (nonatomic, strong, nullable) NSDictionary *grabStyleDictionary;

/**
 * The presenting navigation controller
 */
@property (nonatomic, weak, nullable) UINavigationController *grabNavigationController;

/**
 * Positiong/Location Accuracy setting
 * Setting this to YES allows the SDK to track the users position/location at the highest
 * level of accuracy.  This also drains the battery more quickly.
 *
 * Default setting is NO.
 */
@property (nonatomic) BOOL useBestForNavigation;

/**
 * Setting this to YES allows the SDK to use the heading derived from Core Location.
 * Otherwise the heading is calculated via change in position.
 *
 * Default setting is YES.
 */
@property (nonatomic) BOOL useHeading;

/**
 * Setting this to YES disables "Follow-Me Mode" with regard to position updates.
 * It does not impact the UI.
 *
 * Default is NO.
 */
@property (nonatomic) BOOL disableFollowMeMode;

/**
 * Delay between position updates.  Default is 1.9 seconds.
 *
 * When in Follow-Me Mode the amount of time before a new position update is accepted.
 */
@property (nonatomic, strong, nonnull) NSNumber *positionUpdatesDelay;


/**
 * In order to track the user's location the LocusLabs SDK must ask the user for permission to use location services.
 * There are (currently) two possible types of permission to request:
 *
 * - "when in use"
 * - "always"
 */
typedef NS_ENUM(unsigned long, LLLocationAuthorizationPermissionToRequest) {
    LLLocationAuthorizationPermissionToRequestAlways,
    LLLocationAuthorizationPermissionToRequestWhenInUse
};

/**
 * Set the permission that the SDK will request when asking the user for permission to use location services
 */
@property (nonatomic) LLLocationAuthorizationPermissionToRequest locationAuthorizationPermissionToRequest;

/**
 * Returns the SDK version string.
 */
+ (nonnull NSString *)version;

/**
 * Returns the LLLocusLabs singleton.
 * @returns the singleton
 */
+ (nonnull LLLocusLabs*)setup;

+ (void)reset;

/**
 * Log a person in, associating them with this install of the SDK.
 */
- (void)login:(nonnull LLPerson *)person;

/**
 * Log a person out, removing their association with this install of the SDK.
 */
- (void)logout:(nonnull LLPerson *)person;

@end
