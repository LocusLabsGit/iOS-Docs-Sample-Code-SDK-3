//
//  LLIconButton.h
//  LocusLabsSDK
//
//  Created by Glenn Dierkes on 9/26/14.
//  Copyright © 2014-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Allows to define a button with icon, label and an action to be displayed in the POI view.
 */
@interface LLIconButton : NSObject

@property (nonatomic, readonly) UIImage *icon;
@property (nonatomic, readonly) NSString *label;
@property (nonatomic, readonly, nullable) NSString *analyticsLabel;
@property (nonatomic, readonly, nullable) NSString *analyticsValue;
@property (nonatomic, copy, readonly) void (^action)(void);

/**
 Constructor for creating the icon button.
 
 @param icon image for the button
 @param label label for the button
 @param action callback to be called when the button is tapped
 */
- (instancetype)initWithIcon:(UIImage *)icon label:(NSString *)label action:(void (^)(void))action;

/**
 Constructor for creating the icon button.
 
 @param icon image for the button
 @param label label for the button
 @param analyticsLabel if not @c nil when this button is tapped, analytics event  with given "analyticsLabel" will be recorded
 @param analyticsValue additional value to be provided for analytics when this button is tapped
 @param action callback to be called when the button is tapped
 */
- (instancetype)initWithIcon:(UIImage *)icon label:(NSString *)label analyticsLabel:(nullable NSString *)analyticsLabel analyticsValue:(nullable NSString *)analyticsValue action:(void (^)(void))action;

@end

NS_ASSUME_NONNULL_END
