//
//  LLIconButton.h
//  LocusLabsSDK
//
//  Created by Glenn Dierkes on 9/26/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Allows to define a button with icon, label and an action to be displayed in the POI view.
 */
@interface LLIconButton : NSObject

@property (nonatomic, readonly) UIImage *icon;
@property (nonatomic, readonly) NSString *label;
@property (nonatomic, copy, readonly) void (^action)(void);

/**
 Constructor for creating the icon button.
 
 @param icon image for the button
 @param label label for the button
 @param action callback to be called when the button is tapped
 */
- (instancetype)initWithIcon:(UIImage *)icon label:(NSString *)label action:(void (^)(void))action;

@end
