//
//  Created by Samuel Ziegler on 6/12/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLVenue.h"

@class LLVenueDatabase;
@class LLMap;
@class LLMapView;
@class LLMarker;
@class LLVenueInfo;

typedef enum _LLDownloaderError
{
    ACCOUNT_NOT_FOUND = 0,
    VENUE_NOT_FOUND,
    CORRUPTED_VENUE_DATA,
    UNABLE_TO_STORE_FILE_LOCALLY,
    FILE_NOT_DOWNLOADED_CORRECTEDLY,
    DOWNLOAD_FAILURE
} LLDownloaderError;
/**
 *  Delegates for LLVenueDatabase should implement this protocol.
 */
@protocol LLVenueDatabaseDelegate <NSObject>

@optional

/**
 *  Called with the data returned by the listVenues: method.
 *
 *  @param venueDatabase  the database instance which generated the call
 *  @param venueList      an array of LLVenueInfo instances
 */
- (void)venueDatabase:(LLVenueDatabase *)venueDatabase venueList:(NSArray *)venueList;

/**
 *  Called when no venueList could be returned by listVenues
 *
 *  @param venueDatabase the database instance which generated the call
 *  @param reason the reason for the failure
 */
- (void)venueDatabase:(LLVenueDatabase *)venueDatabase venueListFailed:(NSString *)reason;

/**
 *  Called once a venue has been loaded via the loadVenue: method.
 *
 *  @param venueDatabase the database instance which generated the call
 *  @param venue         the venue
 */
- (void)venueDatabase:(LLVenueDatabase *)venueDatabase venueLoaded:(LLVenue *)venue;

/**
 *  Called once a venue begun downloading maps and other necessary assets.
 *
 *  @param venueDatabase the database instance which generated the call
 *  @param venueId       the venue id
 */
- (void)venueDatabase:(LLVenueDatabase *)venueDatabase venueLoadStarted:(NSString*)venueId;

/**
 *  Called once a venue has completed downloading maps and other necessary assets.
 *
 *  @param venueDatabase the database instance which generated the call
 *  @param venueId       the venue id
 */
- (void)venueDatabase:(LLVenueDatabase *)venueDatabase venueLoadCompleted:(NSString*)venueId;

/**
 *  Called during asset downloads to give a progress update.
 *
 *  @param venueDatabase the database instance which generated the call
 *  @param venueId       the venue id
 *  @param percent       the percent download complete
 */
- (void)venueDatabase:(LLVenueDatabase *)venueDatabase venueLoadStatus:(NSString*)venueId percentage:(int)percent;

/**
 *  Called if an error is encountered while downloading the venue maps.
 *
 *  @param venueDatabase the database instance which generated the call
 *  @param venueId       the venue id
 *  @param errorCode     the code for the failure
 *  @param message       the message for the failure
 */
- (void)venueDatabase:(LLVenueDatabase *)venueDatabase venueLoadFailed:(NSString*)venueId code:(LLDownloaderError)errorCode message:(NSString*)message;

@end

/**
 *  LLVenueDatabase is the primary entry point for all the LocusLabs venue functionality.
 *  To receive any of the asynchronously generated data generated by this class,
 *  you must assign a delegate that implements the methods of the LLVenueDatabaseDelegate protocol.
 */
@interface LLVenueDatabase : NSObject

/**
 Completion block for listing venues.
 */
typedef void (^LLListVenuesBlock) (NSArray<LLVenueInfo *> *venues, NSError *error);
typedef void (^VenueAndMapLoadedBlock) (LLVenue *venue, LLMap *map, LLFloor *floor, LLMarker *marker);
typedef void (^GetLatestAssetVersionBlock) (NSString *version, NSString *errorMessage);
typedef void (^IsVenueOnPhoneBlock) (BOOL venueOnPhone);
typedef void (^IsVenueAvailableOnDeviceBlock) (BOOL venueAvailable);

/**
 *  Delegate for this instance
 */
@property (weak, nonatomic) id<LLVenueDatabaseDelegate> delegate;

/**
 *  Create an instance of LLVenueDatabase to operate on a venue in a "headless" mode = if no map view is to be displayed.
 *
 *  @return the new venue database object
 */
+ (LLVenueDatabase *)venueDatabase;

/**
 *  Create an instance of LLVenueDatabase for a specific LLMapView
 *
 *  @return the new venue database object
 */
+ (LLVenueDatabase *)venueDatabaseWithMapView:(LLMapView*)mapView;

/**
 *  Retrieve the list of venues available in the LocusLabs venue database.  The result will be returned via the
 *  venueDatabase:venueList: delegate method.
 */
- (void)listVenues;

/**
 *  Retrieve the list of venues available in the LocusLabs venue database.  The result will be returned via the provided block.
 *
 *  @param block completion block
 */
- (void)listVenuesWithCompletion:(LLListVenuesBlock)block;

/**
 *  Retrieve the list of venues with given locale available in the LocusLabs venue database.  The result will be returned via the
 *  venueDatabase:venueList: delegate method.
 *
 *  @param locale   locale or nil (when nil provided it'll return venues in all locales)
 */
- (void)listVenuesForLocale:(NSString*)locale;

/**
 *  Retrieve the list of venues with given locale available in the LocusLabs venue database. The result will be returned via the provided block.
 *
 *  @param locale    locale or nil (when nil provided it'll return venues in all locales)
 *  @param block completion block
 */
- (void)listVenuesForLocale:(NSString*)locale completion:(LLListVenuesBlock)block;

/**
 *  Load a specific venue.  The result will be returned to the delegate via venueDatabase:venueLoaded:
 *  Only 4 concurrent loadVenues can be handled simultaneously.  Doing more than 4 could result in load failures.
 *
 *  **Warning**: this method should only be used for "headless" mode of interaction with the SDK. So it only should be used
 *  if **LLMapView is not used**. If the intention is to display the map in the LLMapView use [LLVenueDatabase loadVenueAndMap:block:] or
 *  [LLVenueDatabase loadVenueAndMap:initialSearch:iconUrl:block:] instead.
 *  Using this method when LLVenueDatabase was initiated with [LLVenueDatabase venueDatabaseWithMapView:] is not supported.
 *
 *  @param venueId identifies the venue to load
 */
- (void)loadVenue:(NSString *)venueId;

/**
 * Has the map data for the specified venueId already been downloaded to the phone?
 *
 * Note: no information is returned about whether the version on the phone is the most up-to-date version
 */
- (void)isVenueOnPhone:(NSString*)venueId block:(IsVenueOnPhoneBlock)block;

typedef NS_ENUM(NSInteger, LLVenueDownloadConstraint) {
    LLVenueDownloadConstraintDownloadViaWifiOrPhone = 0,
    LLVenueDownloadConstraintDownloadOnlyViaWifi = 1,
    LLVenueDownloadConstraintDisallowDownloading = 2,
};

/**
 *
 */
@property (nonatomic, assign) LLVenueDownloadConstraint downloadConstraint;

/**
 *  @param venueId identifies the venue to load
 *  @param initialSearch is a search string to zoom into as an initial position
 */
- (void)loadVenueAndMap:(NSString *)venueId initialSearch:(NSString *)initialSearch iconUrl:(NSString*)iconUrl block:(VenueAndMapLoadedBlock)block;

/**
 *  Load a specific venue.  The result will be returned to the delegate via venueDatabase:venueLoaded:
 *  Only 4 concurrent loadVenues can be handled simultaneously.  Doing more than 4 could result in load failures.
 *
 *  @param venueId identifies the venue to load; zooms to venue's default center and radius
 */
- (void)loadVenueAndMap:(NSString *)venueId block:(VenueAndMapLoadedBlock)block;

/**
 * Returns the latest version for the given venueId.
 * The latest venue id is retrieved by checking the latest available content on the server.
 * If the function is unable to connect to the server or the venueId is bad a 
 * non-nil "errorMessage" will be returned.
 *
 *  @param venueId the venue to check
 *  @param block completion block
 */
- (void)getLatestAssetVersion:(NSString *)venueId block:(GetLatestAssetVersionBlock)block;

/**
 * Downloads from the server the latest content for the given venueId.
 *
 * The delegate methods venueLoadStarted, venueLoadCompleted, venueLoadStatus and venueLoadFailed will be called.
 *
 *  @param venueId the venueId to be downloaded
 */
- (void)downloadLatestVenue:(NSString *)venueId;

/**
 * Checks if the given venueId is on the device for the specific version.
 * If version is null, then checks if any version of the venueId is on the device.
 */
- (void)isVenueAvailableOnDevice:(NSString*)venueId forVersion:(NSString*)version block:(IsVenueAvailableOnDeviceBlock)block;

/**
 * Returns the Install ID, an identifier associated with server-side event logging for user analytics.
 *
 * **Deprecated**: use LLLocusLabs installId property instead
 */
- (void)getInstallId:(void (^)(NSString *installId))block __attribute__((deprecated("use LLLocusLabs installId property instead ")));

@end

