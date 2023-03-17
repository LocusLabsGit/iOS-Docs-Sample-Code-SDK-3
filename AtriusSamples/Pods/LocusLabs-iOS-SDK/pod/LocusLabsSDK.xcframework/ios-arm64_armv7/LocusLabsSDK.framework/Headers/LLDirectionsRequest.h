//
// Created by Rafal Hotlos on 2019-07-26.
//  Copyright © 2019-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLPosition;


/**
 * The start and end points of a route, along with routing options.
 */
@interface LLDirectionsRequest : NSObject

/**
 * Constructor initiating with start and end position.
*/
- (nonnull instancetype)initWithStartPosition:(nonnull LLPosition *)startPosition endPosition:(nonnull LLPosition *)endPosition;

/**
 * The starting point for routing directions.
 */
@property (nonatomic, strong, nullable) LLPosition *startPosition;

/**
 * The end point for routing directions.
 */
@property (nonatomic, strong, nullable) LLPosition *endPosition;

@end


@interface LLDirectionsRequest (LLRoutingOptions)

/**
 * If set to <code>YES</code> it'll calculate route that is wheelchair accessible. If no wheelchair accessible route
 * exists it'll result in route not found.
 *
 * By default set to <code>NO</code>, meaning any route (wheelchair accessible or not) is accepted.
 */
@property (nonatomic) BOOL forceWheelchairAccessibleRoute;

/**
 * Set allowed queue subtype ids for given queue type id.
 *
 * See LLQueue.h for available categories and types.
 *
 * @param queueSubtypeIds an array of [LLQueueSubtype subtypeId]
 * @param queueTypeId [LLQueueType typeId]
 */
- (void)setQueueSubtypeIds:(nullable NSArray<NSString *> *)queueSubtypeIds forQueueTypeId:(nonnull NSString *)queueTypeId;

- (void)setSecurityTypeIds:(nullable NSArray<NSString *> *)securityTypeIds forSecurityCategoryId:(nonnull NSString *)securityCategoryId __attribute__((deprecated("use setQueueSubtypeIds:forQueueTypeId: instead")));;

/**
 * Provides direct access to all configured queue types.
 *
 * Instead of setting this value directly, [LLDirectionsRequest setQueueSubtypeIds:forQueueTypeId:] might be used
 * to configure the options by category.
 */
@property (nonatomic, strong, nullable) NSMutableDictionary<NSString *, NSArray<NSString *> *> *queueRoutingOptions;

@property (nonatomic, strong, nullable) NSMutableDictionary<NSString *, NSArray<NSString *> *> *securityRoutingOptions __deprecated_msg("use queueRoutingOptions instead");

@end

@interface LLDirectionsRequest (LLRoutingMultipleEndPositions)
/**
 * Initiates directions request with multiple end positions. This will create a route starting at startPosition and going
 * through all of the endPositions in the order as defined in the input array.
 *
 * If this constructor is used then [LLDirectionsRequest endPosition] will return the last endPosition and setting endPosition
 * will reset endPositions to just contain the one given end position.
 */
- (nonnull instancetype)initWithStartPosition:(nonnull LLPosition *)startPosition endPositions:(nonnull NSArray<LLPosition *> *)endPositions;

/**
 * Direct access to set endPositions, settings this property impacts the [LLDirectionsRequest endPosition].
 */
@property (nonatomic, strong, nullable) NSMutableArray<LLPosition *> *endPositions;
@end
