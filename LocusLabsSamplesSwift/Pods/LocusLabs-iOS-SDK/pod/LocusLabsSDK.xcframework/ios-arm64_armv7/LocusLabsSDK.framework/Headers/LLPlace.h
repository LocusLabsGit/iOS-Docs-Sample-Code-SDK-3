//
// Created by Rafal Hotlos on 03/04/2018.
//  Copyright © 2018-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LLPlaceBehavior) {
    LLPlaceBehaviorSearch,
    LLPlaceBehaviorPOI
};

@interface LLPlace : NSObject

- (instancetype)initWithBehavior:(LLPlaceBehavior)behavior values:(NSArray<NSString*>*)values displayName:(NSString*)displayName icon:(NSString *)icon;

@property (nonatomic, readonly) LLPlaceBehavior behavior;
@property (nonatomic, readonly) NSArray<NSString*> *values;
@property (nonatomic, readonly) NSString *displayName;
@property (nonatomic, readonly) NSString *icon;

@end
