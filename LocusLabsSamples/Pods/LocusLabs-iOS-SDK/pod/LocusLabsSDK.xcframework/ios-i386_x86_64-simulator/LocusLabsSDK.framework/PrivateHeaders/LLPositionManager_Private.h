//
// Created by Rafal Hotlos on 09/10/2019.
//  Copyright © 2019-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocusLabsSDK/LLPositionManager.h>

@class LLBeaconsPositioning;

@interface LLPositionManager () <CLLocationManagerDelegate>

- (CLLocationManager *)locationManager;

+ (void) requestLocationPermissionFromUser:(CLLocationManager*)locationManager;

@end
