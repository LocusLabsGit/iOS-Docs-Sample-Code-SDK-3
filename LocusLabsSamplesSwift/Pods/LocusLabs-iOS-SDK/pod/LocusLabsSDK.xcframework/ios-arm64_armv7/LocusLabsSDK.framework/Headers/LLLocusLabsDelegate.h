//
//  LLLocusLabsDelegate.h
//  LocusLabsSDK
//
//  Created by Sam Ziegler on 6/4/15.
//  Copyright © 2015-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLPerson;
@class LLLocusLabs;

@protocol LLLocusLabsDelegate <NSObject>

@optional

/**
 * Called when a login is successful
 */
- (void)locusLabs:(LLLocusLabs *)locuslabs loginSuccessful:(LLPerson *)person;

/**
 * Called when a logout is successful
 */
- (void)locusLabs:(LLLocusLabs *)locuslabs logoutSuccessful:(LLPerson *)person;

@end