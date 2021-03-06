//
//  LLTheme.h
//  LocusLabsSDK
//
//  Created by Sam Ziegler on 7/13/16.
//  Copyright © 2016-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * The LLTheme class is used to apply GUI properties such as fonts and colors to the widgets provided by the SDK.  LLThemes are immutable objects, but
 * new themes can be created via the LLThemeBuilder class.
 */
@interface LLTheme : NSObject

/**
 * Returns a singleton containing the default SDK theme.
 * @return the default theme
 */
+ (nonnull LLTheme *)defaultTheme;
/**
 * Returns the dark color SDK theme.
 * @return the dark theme
 */
+ (nonnull LLTheme *)darkTheme;

+ (nullable LLTheme *)themeFromPath:(nonnull NSString *)path;

- (nullable NSString *)getPropertyAsString:(nullable NSString *)property;
- (nullable NSNumber *)getPropertyAsNumber:(nullable NSString *)property;
- (nullable UIFont *)getPropertyAsFont:(nullable NSString *)property;
- (nullable UIColor *)getPropertyAsColor:(nullable NSString *)property;
- (nullable NSDictionary *)getPropertyAsDictionary:(nullable NSString *)property;
- (nullable NSObject *)getProperty:(nullable NSString *)property;

@end
