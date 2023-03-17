//
//  LLVenueInfo.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/12/14.
//  Copyright © 2014-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  The basic information about a venue as returned by the LLVenueDatabase listVenues: method.
 */
@interface LLVenueInfo : NSObject

/**
 *  The venue identifier.  This is used to create an instance of the LLVenue class via the LLVenueDatabase loadVenue: method.
 */
@property (retain, nonatomic) NSString *venueId;

/**
 *  The localized name of this venue.
 */
@property (retain, nonatomic) NSString *name;

@property (retain, nonatomic) NSString *airportCode __deprecated_msg("use venueCode instead");

/**
 *  The venue code
 */
@property (retain, nonatomic) NSString *venueCode;

/**
 *  The locale
 */
@property (retain, nonatomic) NSString *locale;

/**
 * If it's <code>YES</code> it means that POIs in this venue have dynamically updated security queue wait time data
 */
@property (nonatomic, readonly) BOOL hasDynamicSecurityWaitTimePOIs;

/**
 * If it's <code>YES</code> it means that POIs in this venue have dynamically updated data
 */
@property (nonatomic, readonly) BOOL hasDynamicPOIs;

/**
 * Map pack v5 moved the positioning supported to the venue list
 */
@property (nonatomic, readonly) NSArray *positioningSupported;

@end
