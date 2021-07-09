//
//  LLBeaconInfo.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/18/14.
//  Copyright © 2014-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLLatLng;

@interface LLBeacon : NSObject <NSCopying>

- (instancetype)initWithUUID:(NSString *)uuid majorId:(NSNumber *)majorId minorId:(NSNumber *)minorId rssi:(NSNumber *)rssi;

@property (nonatomic, readonly) NSString *uuid;
@property (nonatomic, readonly) NSString *floorId;
@property (nonatomic, readonly) NSString *buildingId;
@property (nonatomic, readonly) NSString *venueId;
@property (nonatomic, readonly) NSNumber *majorId;
@property (nonatomic, readonly) NSNumber *minorId;
@property (nonatomic, readonly) NSNumber *rssi;
@property (nonatomic, readonly) LLLatLng *position;

@end
