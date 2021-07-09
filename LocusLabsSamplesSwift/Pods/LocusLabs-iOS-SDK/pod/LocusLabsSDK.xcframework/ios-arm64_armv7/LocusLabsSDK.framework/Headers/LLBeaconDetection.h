//
//  LLBeaconDetection.h
//
//  Created by Glenn Dierkes on 9/18/18.
//  Copyright © 2018-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LLBeaconDetection : NSObject

+ (LLBeaconDetection*)startMonitor;
+ (LLBeaconDetection*)startMonitor:(NSString*)status;
+ (void)stopMonitor;


@end

