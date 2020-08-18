//
//  LLConfiguration.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/17/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLConfiguration : NSObject

+ (LLConfiguration *)sharedConfiguration;

/**
 * <code>assetsOverrideBundle</code> is a bundle that will get checked first for any LocusMaps SDK resources, before the LocusMaps
 * bundle. This allows for customization of resources, like images. They can be provided in a separate bundle or in the
 * application main bundle and will be loaded instead of the default resources.
 *
 * Please note that you can choose to override only a subset of images this way. Whatever is not present in <code>assetsOverrideBundle</code>
 * will be still loaded from the LocusMaps bundle.
 *
 */
@property (nonatomic, strong) NSBundle *assetsOverrideBundle;

@property (nonatomic, strong) NSString *sdkBundleName;

// String & Other Constants
@property (nonatomic, strong) NSString *cancelButtonLabel;
@property (nonatomic, strong) NSString *bottomBarGrabButtonLabel;
@property (nonatomic, strong) NSNumber *currentLevelFadeDuration;
@property (nonatomic, strong) NSNumber *currentLevelFadeDelay;

- (UIImage *)cachedImageFromSDKBundle:(NSString *)imageFilename;
- (void)clearCache;

@end
