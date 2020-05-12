//
//  LLVenueInfo.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/12/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
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

/**
 *  The airport code
 */
@property (retain, nonatomic) NSString *airportCode;

/**
 *  The locale
 */
@property (retain, nonatomic) NSString *locale;

/**
 * If it's <code>YES</code> it means that POIs in this venue have dynamically updated security queue wait time data
 */
@property (nonatomic, readonly) BOOL hasDynamicSecurityWaitTimePOIs;

@end