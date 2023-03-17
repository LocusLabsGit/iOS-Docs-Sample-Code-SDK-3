//
//  LLAirline.h
//  LocusLabsSDK
//
//  Created by Sam Ziegler on 11/2/14.
//  Copyright © 2014-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LLAirline : NSObject

+ (LLAirline *)oceanicAirlines;

@property (strong) NSString *name;
@property (strong) UIImage *smallLogo;

@end