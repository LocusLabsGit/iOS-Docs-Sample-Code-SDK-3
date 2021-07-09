//
// Created by Rafal Hotlos on 13/06/2018.
//  Copyright © 2018-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLPosition;


@protocol LLNavigationDelegate <NSObject>

- (void)navigationStarted:(LLPosition *)startPoint endPoint:(LLPosition *)endPoint;

@end

@interface LLNavigation : NSObject

+ (id)initTracking;

@property (nonatomic, assign) id <LLNavigationDelegate> delegate;

@end
