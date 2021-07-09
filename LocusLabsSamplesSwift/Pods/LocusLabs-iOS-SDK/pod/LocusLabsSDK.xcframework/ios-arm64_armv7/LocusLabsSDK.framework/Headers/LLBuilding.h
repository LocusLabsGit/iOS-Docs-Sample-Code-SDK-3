//
//  LLBuilding.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/12/14.
//  Copyright © 2014-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLLocation.h"

@class LLBuilding;
@class LLFloor;

/**
 *  Delegate to process responses to the asynchronous methods of a LLBuilding object.
 */
@protocol LLBuildingDelegate <NSObject>

@optional

/**
 *  The list of floors found in this building.
 *
 *  @param building the object which generated this list
 *  @param floors   an array of LLFloorInfo objects
 */
- (void)building:(LLBuilding *)building floorList:(NSArray *)floors;

- (void)building:(LLBuilding *)building floorLoaded:(LLFloor *)floor;

@end

@interface LLBuilding : LLLocation

@property (weak, nonatomic) id <LLBuildingDelegate> delegate;

/**
 *  Unique identifier for this building
 *
 *  @return the building identifier
 */
@property (nonatomic, readonly) NSString *buildingId;

/**
 * Return the list of floors found in this building.
 */
@property (nonatomic, readonly) NSArray<LLFloor *> *floors;

/**
 * Contains the id of the default floor for this building
 */
@property (nonatomic, readonly) NSString *defaultFloorId;

/**
 *  Load and create a new instance of a LLFloor object for a specific floor of this building.
 *
 * **Deprecated:**: use <code>floors</code> property instead
 *  @param floorId the identifier of the floor to load
 */
- (LLFloor *)loadFloor:(NSString *)floorId __attribute__((deprecated("use floors property instead")));

/**
 *  Generate a list of the floors found in this building.
 *
 * **Deprecated:**: use <code>floors</code> property instead
 */
- (NSArray *)listFloors __attribute__((deprecated("use floors property instead")));

/**
 * getFloorIdForCLFloor
 */
- (NSString *)getFloorIdForCLFloor:(NSNumber *)clFloor;


/**
 * getFloorIdForOrdinal
 */
- (NSString *)getFloorIdForOrdinal:(NSNumber *)ordinal;

@end