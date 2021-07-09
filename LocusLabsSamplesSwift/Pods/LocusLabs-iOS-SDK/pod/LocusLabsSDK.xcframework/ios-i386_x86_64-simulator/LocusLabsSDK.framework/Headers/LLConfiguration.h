//
//  LLConfiguration.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/17/14.
//  Copyright © 2014-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLConfiguration : NSObject

+ (nonnull LLConfiguration *)sharedConfiguration;

/**
 * <code>assetsOverrideBundle</code> is a bundle that will get checked first for any LocusMaps SDK resources, before the LocusMaps
 * bundle. This allows for customization of resources, like images. They can be provided in a separate bundle or in the
 * application main bundle and will be loaded instead of the default resources.
 *
 * Please note that you can choose to override only a subset of images this way. Whatever is not present in <code>assetsOverrideBundle</code>
 * will be still loaded from the LocusMaps bundle.
 *
 */
@property (nonatomic, strong, nullable) NSBundle *assetsOverrideBundle;

/**
 This property controls which language is used for localized strings displayed by the LocusMaps.
 
 It needs to be set to one of the values of available localizations for LocusMaps bundle.
 Setting this property to an unsupported value or nil results in resetting it to a default value, which is the first localization from <code>preferredLocalizations</code> of the LocusMaps bundle.
 */
@property (nonatomic, copy, null_resettable) NSString *language;

@property (nonatomic, strong, nonnull) NSString *sdkBundleName;

// String & Other Constants
@property (nonatomic, strong, null_resettable) NSString *cancelButtonLabel;
@property (nonatomic, strong, null_resettable) NSString *bottomBarGrabButtonLabel;
@property (nonatomic, strong, nonnull) NSNumber *currentLevelFadeDuration;
@property (nonatomic, strong, nonnull) NSNumber *currentLevelFadeDelay;

- (nullable UIImage *)cachedImageFromSDKBundle:(nullable NSString *)imageFilename;
- (void)clearCache;

@end
