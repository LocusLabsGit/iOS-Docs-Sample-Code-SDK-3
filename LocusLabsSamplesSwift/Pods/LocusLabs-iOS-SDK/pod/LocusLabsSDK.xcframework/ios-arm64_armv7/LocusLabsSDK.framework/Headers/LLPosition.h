//
//  LLPosition.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/12/14.
//  Copyright © 2014-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLLatLng;
@class LLFloor;

/**
 *  Represents a specific geographic position inside of a building.
 */
@interface LLPosition : NSObject

/**
 * Designated initializer of LLPositon
 */
- (instancetype)initWithFloorId:(NSString *)floorId latLng:(LLLatLng *)latLng;

/**
 *
 * Deprecated. Use initWithFloorId:latLng: instead
 * @deprecated
 */
- (id)initWithFloor:(LLFloor *)floor latLng:(LLLatLng *)latLng __deprecated;

/**
 *  Name of the location if available.
 *  Usually available if the position specifies a specific POI.
 */
@property (retain,nonatomic) NSString *name;

/**
 *  Boolean which is true if the position within the proximity of a venue.
 */
@property (retain,nonatomic) NSNumber *nearVenue;

/**
 *  Identifies the venue (if known).
 */
@property (retain,nonatomic) NSString *venueId;

/**
 *  Identifies the building (if known).
 */
@property (retain,nonatomic) NSString *buildingId;

/**
 *  Identifies the floor (if known).
 */
@property (retain,nonatomic) NSString *floorId;

/**
 * Identifies the section (if known).
 */
@property (retain,nonatomic) NSString *sectionId __attribute__((deprecated("this attribute is deprecated")));

/**
 *  The geographic position (if known).
 */
@property (retain,nonatomic) LLLatLng *latLng;

/**
 *  The geographic heading (if known).
 */
@property (retain,nonatomic) NSNumber *heading;

/**
 *  The error radius if known.
 */
@property (retain,nonatomic) NSNumber *errorRadius;

/**
 *  If in an airport, whether or not this POI is before or after security.
 */
@property (strong,nonatomic) NSNumber *isAfterSecurity __attribute__((deprecated("use LLPOI.isAfterSecurity")));

@end
