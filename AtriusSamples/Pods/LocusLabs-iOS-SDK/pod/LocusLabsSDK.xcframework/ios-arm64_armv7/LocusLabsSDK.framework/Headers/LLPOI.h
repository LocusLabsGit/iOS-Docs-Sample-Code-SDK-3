//
//  LLPOI.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 7/24/14.
//  Copyright © 2014-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLSearchResult.h"

@class LLPosition;
@class LLFlight;

/**
 *  All of the available information about a POI.
 */
@interface LLPOI : LLSearchResult


/**
    Types of POI sensor status
 
 OPEN - POI sensor staatus is open
 CLOSED - POI sensor status is closed
 UNAVAILABLE - POI sensor status is unavailable
 
 */
typedef enum {
    LLSensorStatusOPEN = 1,
    LLSensorStatusCLOSED = 2,
    LLSensorStatusUNAVAILABLE = 3
} LLSensorStatus;

/**
 *  The URL associated with this POI.  For example, this may be a company website if the POI is a store.
 */
@property (nonatomic, readonly) NSString *url;

/**
 *  The visible value to display for the URL property. This could be the domain name or a proper name. Absence of this property will display the URL as "Website".
 */
@property (nonatomic, readonly) NSString *urlDisplay;

/**
 *	Additional attributes for the POI.
 */
@property (nonatomic, readonly) NSDictionary *additionalAttributes;

/**
 * External ids for this POI in the form of @[@{@"type": @"...", @"id": @"..."}]
 */
@property (nonatomic, readonly) NSArray *externalIds;

/**
 *  An image of the POI.
 */
@property (nonatomic, readonly) NSString *image;

/**
 *  Additional images of the POI.
 */
@property (nonatomic, readonly) NSArray *additionalImages;

/**
 *  Absolute URL of image
 */
@property (nonatomic, readonly) NSURL *imageUrl;

/**
 *	Absolute URLs for all additional images
 */
@property (nonatomic, readonly) NSArray *additionalImageUrls;

/**
 *  An array of NSStrings which are used to classify this POI.
 */
@property (nonatomic, readonly) NSArray<NSString *> *tags;

/**
 *  Subset of the tags meant for display.
 */
@property (nonatomic, readonly) NSArray<NSString *> *displayTags;

/**
 *  The category that this POI is apart of.
 */
@property (nonatomic, readonly) NSString *category;

/**
 *  A localized description of this POI.
 */
@property (nonatomic, readonly) NSString *poiDescription;
@property (nonatomic, readonly) BOOL hasDescription;

/**
 *  A phone number for this POI, if applicable.
 */
@property (nonatomic, readonly) NSString *phone;

/**
 *  The operating hours of this POI, if applicable.
 */
@property (nonatomic, readonly) NSString *hours;

/**
 *  Radius
 */
@property (nonatomic, readonly) NSNumber *radius;

/**
 *  Logo
 */
@property (nonatomic, readonly) NSString *logo;

/**
 *  Absolute URL of the logo
 */
@property (nonatomic, readonly) NSURL *logoUrl;



/**
 *  An arbitrary userLabel set in LLMapView.addUserPOI
 */
@property (nonatomic, strong) NSString *userLabel;

@property (nonatomic, strong) LLFlight *flight;

/**
 *  Properties used for POI display
 */
@property (nonatomic, readonly) NSDictionary *displayProperties;

/**
 An array of 7 arrays (one for each week day) containing LLOperatingHours objects.
 A POI can be open for a variable number of blocks throughout a day, or none at all if it is closed.
 */
@property (nonatomic, readonly) NSArray *detailedOperatingHours;

/**
 Easy-to-check flag for whether or not this POI has a list of operating hours
 */
@property (nonatomic, readonly) BOOL hasOperatingHours;

/**
 * Indicates if the POI has any navigation directions.
 * If nil then the POI can be navigated to/from.
 * Otherwise if non-nil and true then the POI can NOT be navigated/from.
 */
@property (nonatomic, readonly) NSNumber *noDirections;

/**
 * Property denotes if the POI is temporarily closed. Only relevant for security checkpoints.
 * It's NO by default if no server side data is available (yet).
 */
@property (nonatomic, readonly) BOOL isTemporarilyClosed;

/**
 * Property denotes the POI sensor status. Only relevant venues using Distech open/close sensors.
 * It's UNAVAILABLE by default if no server side data is available.
 */
@property (nonatomic, readonly) LLSensorStatus openClosedSensorStatus;

/**
 * Queue time in minutes. Only relevant if isTemporarilyClosed == NO. This property may have a NSNotFound value,
 * meaning that the data is not available (yet).
 */
@property (nonatomic, readonly) NSUInteger queueTime;

/**
 * Describes if the queueTime is a real time (isQueueTimeDynamic == YES) or is just an estimate (isQueueTimeDynamic == NO).
 * Only relevant if isTemporarilyClosed == NO.
 * It's NO by default if no server side data is available (yet).
 */
@property (nonatomic, readonly) BOOL isQueueTimeDynamic;

/**
 *  If in an airport, whether or not this POI is before or after security.
 */
@property (nonatomic, readonly) NSNumber *isAfterSecurity;

- (BOOL)isEqual:(id)object;

@property (nonatomic, readonly) NSUInteger hash;

@end
