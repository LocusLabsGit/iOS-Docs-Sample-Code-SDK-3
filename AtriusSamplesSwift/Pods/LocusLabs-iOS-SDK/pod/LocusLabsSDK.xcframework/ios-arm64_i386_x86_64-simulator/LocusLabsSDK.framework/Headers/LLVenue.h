//
//  LLVenue.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/12/14.
//  Copyright © 2014-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLConfiguration.h"
#import "LLBeacon.h"
#import "LLLocation.h"
#import "LLSecurity.h"

@class LLVenue;

@class LLBuilding;
@class LLFloor;
@class LLSearch;
@class LLPOIDatabase;
@class LLPosition;
@class LLNavigationPath;
@class LLSecurityCategory;
@class LLQueueType;
@class LLDirectionsRequest;

/**
 *  Defines the delegate methods of a Vemue object.  Several methods within the Venue object may require asynchronous calls to the LocusLabs
 *  servers.  These delegate methods are called when those asynchronous calls return.
 */

@protocol LLVenueDelegate <NSObject>

@optional

/**
 *  Returns the list of buildings generated by a call to LLVenue listBuildings
 *
 *  @param venue     the object which generated this list
 *  @param buildings an array of LLBuildingInfo objects
 */
- (void)venue:(LLVenue *)venue buildingList:(NSArray *)buildings;

/**
 *  A new instance of a LLBuilding object as loaded via the LLVenue loadBuilding: method.
 *
 *  @param venue    the object which loaded the building
 *  @param building the newly created LLBuilding object
 */
- (void)venue:(LLVenue *)venue buildingLoaded:(LLBuilding *)building;

/**
 *  The result of a navigation call.
 *
 *  @param venue  			the object which performed the navigation
 *  @param navigationPath	the resulting navigation path
 *  @param startPosition 	the start position of the navigation
 *  @param destinations		the array of LLPosition destinations
 */
- (void)venue:(LLVenue *)venue navigationPath:(LLNavigationPath *)navigationPath from:(LLPosition *)startPosition toDestinations:(NSArray *)destinations;

/**
 *  The result of a update navigation path call.
 *
 *  @param venue  			the object which performed the navigation
 *  @param navigationPath	the resulting navigation path
 *  @param startPosition 	the start position of the navigation
 */
- (void)venue:(LLVenue *)venue updatePath:(LLNavigationPath *)navigationPath from:(LLPosition *)startPosition to:(LLPosition *)endPosition;

/**
 *  The result of a timeEstimate call.
 *
 *  @param venue  			the object which performed the navigation
 *  @param timeEstimate     the time to traverse from the start to the end position
 */
- (void)venue:(LLVenue *)venue timeEstimate:(NSNumber *)timeEstimate from:(LLPosition *)startPosition to:(LLPosition *)endPosition;

@end

/**
 *  The LLVenue class provides the ability to navigate and search a venue as well as providing access to the buildings found within the venue.
 *  Instances of this class should never be created directly.  They must be generated via the loadVenue: method of LLVenueDatabase.
 */
@interface LLVenue : LLLocation

/**
 *  Delegate to handle the results of the asynchronous calls on this object
 */
@property (weak, nonatomic) id <LLVenueDelegate> delegate;

/**
 * Contains the id of the default building for this venue
 */
@property (nonatomic, readonly) NSString *defaultBuildingId;

/**
 * Returns the ordinal associated with the given floorId.
 */
- (NSNumber *)getOrdinalForFloorId:(NSString *)floorId;

/**
 * Returns true or false. True if the provided latLng is in the venue.
 */
- (NSNumber *)isLatLngInVenue:(LLLatLng *)latLng;

/**
 *  The IATA or ICAO code for this airport
 *
 *  @return the airport code
 */
@property (nonatomic, readonly) NSString *airportCode;

/**
 *  The venue identifier for this venue
 *
 *  @return the venue id
 */
@property (nonatomic, readonly) NSString *venueId;

/**
 * If it's <code>YES</code> it means that POIs in this venue have dynamically updated security queue wait time data
 */
@property (nonatomic, readonly) BOOL hasDynamicSecurityWaitTimePOIs;

/**
 * If it's <code>YES</code> it means that POIs in this venue have dynamically updated data
 */
@property (nonatomic, readonly) BOOL hasDynamicPOIs;


/**
 * The beacon regions for this venue.
 */
@property (nonatomic, readonly) NSArray *beaconRegions;

@property (nonatomic, readonly) LLPosition *position;

@property (nonatomic, readonly) NSString *assetVersion;

@property (nonatomic, readonly) NSString *version;

@property (nonatomic, readonly) NSArray *positioningSupported;

@property (nonatomic, readonly) NSString *uber;

@property (nonatomic, readonly) BOOL supportsStepwiseDirections;

/**
 * The list of buildings that make up this venue.
 */
@property (nonatomic, readonly) NSArray<LLBuilding *> *buildings;

/**
 *  Retrieve the list of buildings that make up this venue. The result is passed back via the venue:buildingList: method of the delegate.
 *
 * **Deprecated:**: use <code>buildings:</code> property instead
 */
- (NSArray *)listBuildings __attribute__((deprecated("use buildings property instead")));

/**
 *  Load a specific building.  This method loads the data about the building and creates a new instance of LLBuilding which is returned via the delegate method.
 *
 * **Deprecated:**: use <code>buildings</code> property instead
 *
 *  @param buildingId identifies the building to load
 */
- (LLBuilding *)loadBuilding:(NSString *)buildingId  __attribute__((deprecated("use buildings property instead")));

/**
 * **Deprecated:**: use <code>buildings</code> property instead
 */
- (LLBuilding *)loadBuildingSync:(NSString *)buildingId __attribute__((deprecated("use buildings property instead")));

/**
 *  Calculate a navigation path from the start position to the end postion.
 *
 *  @param startPosition the starting point of the navigation
 *  @param endPosition   the end point of the navigation
 */
- (void)navigateFrom:(LLPosition *)startPosition to:(LLPosition *)endPosition;

/**
 *  Update the navigation path from the start position to the end postion.
 *
 * **Deprecated**: use navigate* methods instead
 *
 *  @param startPosition the starting point of the navigation
 *  @param endPosition   the end point of the navigation
 */
- (void)updatePathFrom:(LLPosition *)startPosition to:(LLPosition *)endPosition;

/**
 *  Generate a navigation path from a start point to one or more destinations.
 *
 *  @param startPosition the starting point of the navigation
 *  @param destinations  a destination array of LLPosition instances
 */
- (void)navigateFrom:(LLPosition *)startPosition toDestinations:(NSArray *)destinations;

/**
 * Generate a navigation path for given directionsRequest.
 *
 * @param directionsRequest  configuration of LLDirectionsRequest
 * @param completion    the completion callback that will receive the resulting LLNavigationPath
 */
- (void)navigate:(LLDirectionsRequest *)directionsRequest completion:(void (^)(LLNavigationPath *navigationPath, NSError *error))completion;

/**
 * Calculate the time to travel for given directionsRequest
 *
 * @param directionsRequest  configuration of LLDirectionsRequest
 * @param completion    the completion callback that will receive the resulting time
 */
- (void)timeEstimate:(LLDirectionsRequest *)directionsRequest completion:(void (^)(NSNumber *timeEstimate, NSError *error))completion;

/**
 *  Calculate the time to travel from the start position to the end position.
 *
 * **Deprecated**: use the timeEstimateFrom:to:completion: instead"
 *
 *  @param startPosition the starting point
 *  @param endPosition   the end point
 */
- (void)timeEstimateFrom:(LLPosition *)startPosition to:(LLPosition *)endPosition __attribute__((deprecated("use the timeEstimateFrom:to:completion: instead")));

/**
 *  Calculate the time to travel from the start position to the end position.
 *
 *  @param startPosition the starting point
 *  @param endPosition   the end point
 *  @param completion    the completion callback that will receive the result
 */
- (void)timeEstimateFrom:(LLPosition *)startPosition to:(LLPosition *)endPosition completion:(void (^)(NSNumber *))completion;

/**
 *  Creates a search object for quering the database within this search context.
 *
 *  @return the LLSearch object
 */
- (LLSearch *)search;

/**
 *  Returns a new LLPOIDatabase for retrieving information about POIs found in this venue.
 *
 *  @return the POI database
 */
- (LLPOIDatabase *)poiDatabase;

/**
 * An array of LLSecurityCategory supported by this venue.
 *
 * **Deprecated**: use queueTypes instead
 */
@property (nonatomic, readonly) NSArray<LLSecurityCategory *> *securityCategories __attribute__((deprecated("use queueTypes")));

/**
 * An array of LLQueueType supported by this venue.
 */
@property (nonatomic, readonly) NSArray<LLQueueType *> *queueTypes;

@property (nonatomic, readonly) NSArray<NSString *> *searchSuggestions;

- (void)clearPosition;

@end
