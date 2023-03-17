//
//  LLPlace_Private.h
//  LocusLabsSDK
//
//  Created by Rafal Hotlos on 29/05/2020.
//  Copyright © 2020-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocusLabsSDK/LLMap.h>

@interface LLPlace ()

/**
 Init Action (also referred to as Recommended Place) with provided action and display name and icon
 
 @param action block invoked when the action is tapped in the list of actions
 @param displayName the name displayed in the list of actions
 @param icon icon used in the list of actions
 */
- (instancetype)initWithAction:(void (^)(void))action displayName:(NSString *)displayName icon:(NSString *)icon;

@end
