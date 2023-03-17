//
// Created by Rafal Hotlos on 05/12/2018.
//  Copyright © 2018-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * This class is used for configuring user preferences.
 * It has a singleton instance which is accessed via the [LLUserPreferences shared] method.
 */
@interface LLUserPreferences : NSObject

/**
 * Shared user preferences object.
 */
+ (nonnull instancetype)shared NS_SWIFT_NAME(shared());

/**
 * Clears all user preferences.
 */
- (void)purge;

/**
 * Prefer the wheelchair accessible routes when navigating. NO by default.
 */
@property (nonatomic) BOOL preferWheelchairAccessibleNavigation;

/**
 * Set user preferences for queues.
 *
 * For example: <code>[preferences setQueueSubtypeIds:@[LLSecurityLaneGeneral, LLSecurityLaneTSAPre] forQueueTypeId:LLQueueTypeSecurityLane]</code>
 *
 * See LLQueue.h for available categories and types.
 *
 * @param queueSubtypeIds an array of [LLQueueSubtype subtypeId]
 * @param queueTypeId [LLQueueType typeId]
 */
- (void)setQueueSubtypeIds:(nullable NSArray<NSString *> *)queueSubtypeIds forQueueTypeId:(nonnull NSString *)queueTypeId;

- (void)setSecurityTypeIds:(nullable NSArray<NSString *> *)securityTypeIds forSecurityCategoryId:(nonnull NSString *)securityCategoryId __attribute__((deprecated("use setQueueSubtypeIds:forQueueTypeId: instead")));

/**
 * Returns an array of queue subtypes for given queue type id. This might be <code>nil</code> if no preferences were set for given type id.
 * @param queueTypeId [LLQueueType typeId]
 * @return an array of [LLQueueSubtype subtypeId]
 */
- (nullable NSArray<NSString *>*)getQueueSubtypeIdsForTypeId:(nonnull NSString *)queueTypeId;

- (nullable NSArray<NSString *>*)getSecurityTypeIdsForSecurityCategoryId:(nonnull NSString *)securityCategoryId __attribute__((deprecated("use getQueueSubtypeIdsForTypeId: instead")));

@end
