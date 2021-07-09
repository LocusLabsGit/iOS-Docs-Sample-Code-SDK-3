//
// Created by Rafal Hotlos on 2019-07-01.
//  Copyright © 2019-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/************************ Queue types ************************/
// Predefined security categories.
extern NSString *const _Nonnull LLQueueTypeSecurityLane;
extern NSString *const _Nonnull LLQueueTypeImmigrationLane;

/************************ Queue subtypes ************************/
// Predefined subtypes of "SecurityLane" queue type
extern NSString *const _Nonnull LLSecurityLaneGeneral;
extern NSString *const _Nonnull LLSecurityLaneTSAPre;
extern NSString *const _Nonnull LLSecurityLaneClear;
extern NSString *const _Nonnull LLSecurityLanePriority;

// Predefined subtypes of "ImmigrationLane" queue type
extern NSString *const _Nonnull LLImmigrationLaneResident;
extern NSString *const _Nonnull LLImmigrationLaneVisitor;
extern NSString *const _Nonnull LLImmigrationLaneGlobalEntry;

@class LLQueueType;
@class LLQueueSubtype;

@compatibility_alias LLSecurityCategory LLQueueType;
@compatibility_alias LLSecurityType LLQueueSubtype;

/**
 * A logical grouping of types of route queue options, such as Security Lanes (for airport checkpoints), Immigration Lanes (for CBP checkpoints),
 * or Secured Employee Entrances (for smart campuses). A single venue can have multiple queue types.
 */
@interface LLQueueType : NSObject

/**
 * Queue typeId to be used for configuring directions request and user preferences.
 *
 * There are constants for predefined type ids: <code>LLQueueTypeSecurityLane</code>, <code>LLQueueTypeImmigrationLane</code>,
 * but this can be any type id supported by the venue.
 */
@property (nonatomic, readonly, nonnull) NSString *typeId;

@property (nonatomic, readonly, nonnull) NSString *categoryId __deprecated_msg("use typeId instead");

/**
 * An array of supported LLQueueSubtype
 */
@property (nonatomic, readonly, nonnull) NSArray<LLQueueSubtype *> *subtypes;

@property (nonatomic, readonly, nonnull) NSArray<LLSecurityType *> *types __deprecated_msg("use subtypes instead");

@end

/**
 * A queue type has one or more subtypes.
 * Example of subtypes are General and Clear for security lane type.
 */
@interface LLQueueSubtype : NSObject

/**
 * Queue subtype to be used for configuring directions request and user preferences.
 *
 * There are constants for predefined subtype ids, for example <code>LLSecurityLaneGeneral</code> security lane or
 * <code>LLImmigrationLaneResident</code> immigration lane but this can be any subtype id supported by the venue.
 *
 * For the full list of predefined values see the LLQueue header file.
 */
@property (nonatomic, readonly, nonnull) NSString *subtypeId;

@property (nonatomic, readonly, nonnull) NSString *typeId __deprecated_msg("use subtypeId instead");

/**
 * The name of security type to be used in user interface
 */
@property (nonatomic, readonly, nonnull) NSString *displayText;
/**
 * The (optional) name of logo file from LocusLabs resources
 */
@property (nonatomic, readonly, nullable) NSString *logo;
/**
 * Denotes if this is a default type for given category
 */
@property (nonatomic, readonly) BOOL isDefault;

@end
