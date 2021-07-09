//
//  LLBuildingInfo.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/12/14.
//  Copyright © 2014-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  The index information about a specific building as returned by the LLVenue listBuildings method.
 */
@interface LLBuildingInfo : NSObject

/**
 *  The unique identifier for this building.  This is used in the LLVenue loadBuilding: method to instantiate an instance of the LLBuilding class.
 */
@property (nonatomic, readonly) NSString *buildingId;

/**
 *  The name of this building.
 */
@property (nonatomic, readonly) NSString *name;

@end