//
//  LLSearchResult.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 7/11/14.
//  Copyright © 2014-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLPOIDataProtocol.h"

@class LLPosition;

/**
 *  A single search result.
 */
@interface LLSearchResult : NSObject <LLPOIData>

/**
 *  The unique identifier for the found POI.  This can be used to access additional data about the POI with
 *  through LLPOIDatabase.
 */
@property (nonatomic, strong, readonly) NSString *poiId;

/**
 *  A localized name of the POI which can be used for display purposes.
 */
@property (nonatomic, strong, readonly) NSString *name;

/**
 *  The geographic position of this POI.
 */
@property (nonatomic, strong, readonly) LLPosition *position;

/**
 * The landmark which is near the POI.
 */
@property (nonatomic, readonly) NSString *nearbyLandmark;

/**
 *  The gate which is near the POI.
 */
@property (nonatomic, strong, readonly) NSString *gate __attribute__((deprecated("use nearbyLandmark instead")));

/**
 *  The terminal which is near the POI.
 */
@property (nonatomic, strong, readonly) NSString *terminal __attribute__((deprecated("use nearbyLandmark instead")));

@end
