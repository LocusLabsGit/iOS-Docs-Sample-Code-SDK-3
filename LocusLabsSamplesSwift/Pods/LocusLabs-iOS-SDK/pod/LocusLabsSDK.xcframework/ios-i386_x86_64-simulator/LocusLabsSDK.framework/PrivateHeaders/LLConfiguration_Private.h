//
// Created by Rafal Hotlos on 25/11/2019.
//  Copyright © 2019-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLConfiguration.h"

@interface LLConfiguration ()

@property (nonatomic, readonly) NSBundle *sdkBundle; // this should be removed, if not used by customers...

@property (nonatomic, strong) NSDictionary *config;
@property (nonatomic) BOOL hours24format;

@property (nonatomic) BOOL recommendedPlacesEnabled DEPRECATED_MSG_ATTRIBUTE("this attribute is not used anymore");

// Remote Assets
@property (nonatomic, strong) NSString *poiImagesUrl;
@property (nonatomic, strong) NSString *poiImagesUrlTemplate;
@property (nonatomic, strong) NSString *poiImagesUrlTemplateCenterCrop;

// Fonts
@property (nonatomic, strong) UIFont *font DEPRECATED_MSG_ATTRIBUTE("this attribute is not used anymore");
@property (nonatomic, strong) UIFont *lightFont DEPRECATED_MSG_ATTRIBUTE("this attribute is not used anymore");
@property (nonatomic, strong) UIFont *boldFont DEPRECATED_MSG_ATTRIBUTE("this attribute is not used anymore");
+ (UIFont *)fontWithSize:(CGFloat)fontSize __attribute__((deprecated("this method is not used anymore"))); // return the font in the given size
+ (UIFont *)lightFontWithSize:(CGFloat)size __attribute__((deprecated("this method is not used anymore"))); // return the lightFont in the given size

// Colors
@property (nonatomic, strong) UIColor *textColor DEPRECATED_MSG_ATTRIBUTE("this attribute is not used anymore");
@property (nonatomic, strong) UIColor *darkTextColor DEPRECATED_MSG_ATTRIBUTE("this attribute is not used anymore");
@property (nonatomic, strong) UIColor *lightTextColor DEPRECATED_MSG_ATTRIBUTE("this attribute is not used anymore");
@property (nonatomic, strong) UIColor *linkColor DEPRECATED_MSG_ATTRIBUTE("this attribute is not used anymore");
@property (nonatomic, strong) UIColor *lightGrayBackgroundColor DEPRECATED_MSG_ATTRIBUTE("this attribute is not used anymore");
@property (nonatomic, strong) UIColor *blueBackgroundColor DEPRECATED_MSG_ATTRIBUTE("this attribute is not used anymore");
@property (nonatomic, strong) UIColor *defaultSearchBarBackgroundColor DEPRECATED_MSG_ATTRIBUTE("this attribute is not used anymore");
@property (assign) CGFloat poiAlphaChannel DEPRECATED_MSG_ATTRIBUTE("this attribute is not used anymore");
@property (nonatomic, strong) UIColor *sponsoredSearchResultBackgroundColor DEPRECATED_MSG_ATTRIBUTE("this attribute is not used anymore");
// return a color with rgb each in the range 0-255 (alpha always set to 1)
+ (UIColor *)colorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue;
+ (UIColor *)gray:(NSUInteger)zeroTo255;     // return a gray with the specified value (0-255) alpha: 1

@property (nonatomic, strong) NSString *bottomBarNavigateButtonLabel DEPRECATED_MSG_ATTRIBUTE("this button has not title");
@property (nonatomic, strong) NSString *bottomBarVenuesButtonLabel DEPRECATED_MSG_ATTRIBUTE("this button is not used");
@property (nonatomic, strong) NSString *bottomBarMyPositionButtonLabel DEPRECATED_MSG_ATTRIBUTE("this button has not title");
@property (nonatomic, strong) NSString *bottomBarLevelsButtonLabel DEPRECATED_MSG_ATTRIBUTE("this button has not title");

@property (nonatomic, strong) NSString *initialAirportCode;

@property (nonatomic, readonly) NSURL *baseURL;
- (NSString *)dataUriForImageFromSDKBundle:(NSString *)fileName;

@end
