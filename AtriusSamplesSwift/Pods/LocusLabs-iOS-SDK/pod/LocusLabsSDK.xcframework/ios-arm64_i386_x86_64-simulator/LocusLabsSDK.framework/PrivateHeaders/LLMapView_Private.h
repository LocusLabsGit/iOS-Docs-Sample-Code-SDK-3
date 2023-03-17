//
//  LLMapView_Private.h
//  LocusLabsSDK
//
//  Created by Rafal Hotlos on 26/05/2020.
//  Copyright © 2020-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocusLabsSDK/LLMapView.h>

@interface LLMapView ()

/**
 * Adds button at the top of the map view. Please note that adding a button on the leading side makes sense only
 * if the "back" button is hidden
 *
 * @param icon - the icon to display
 * @param action - the action to invoke on tap
 * @param leading - if it's on the leading side (left side on LeftToRight layout) or trailing (right on LTR)
 */
- (void)setTopButtonWithIcon:(UIImage *)icon action:(void (^)(void))action leading:(BOOL)leading;

@end
