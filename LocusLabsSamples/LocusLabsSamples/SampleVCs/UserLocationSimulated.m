//
//  UserLocationSimulated.m


//  Copyright © 2021 Atrius, part of Acuity Brands. All rights reserved.
//

#import "UserLocationSimulated.h"
#import <LocusLabsSDK/LocusLabsSDK.h>

@interface UserLocationSimulated () <LLMapViewDelegate, LLVenueDatabaseDelegate>

@property (nonatomic, weak)   LLMapView         *mapView;
@property (nonatomic, strong) LLVenue           *venue;
@property (nonatomic, strong) LLVenueDatabase   *venueDatabase;

@end

@implementation UserLocationSimulated


#pragma mark Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [LLLocusLabs setup].accountId = @"A11F4Y6SZRXH4X";

    // Create a new LLMapView, register as its delegate and add it as a subview
    LLMapView *mapView = [[LLMapView alloc] initWithFrame:self.view.bounds];
    mapView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    mapView.delegate = self;
    [self.view addSubview:mapView];
    
    self.mapView = mapView;
    self.mapView.showTopSafeAreaOverlay = NO;
    self.mapView.darkMode = self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
    
    // Get an instance of LLVenueDatabase, set it's mapview and register as its delegate
    self.venueDatabase = [LLVenueDatabase venueDatabaseWithMapView:self.mapView];
    self.venueDatabase.delegate = self;
    
    [self.venueDatabase loadVenueAndMap:@"lax" block:^(LLVenue *venue, LLMap *map, LLFloor *floor, LLMarker *marker) {
        
        self.venue = venue;
    }];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
    [super traitCollectionDidChange:previousTraitCollection];
    
    self.mapView.darkMode = self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
}

#pragma mark Custom

- (NSDictionary *)locationDictWithLat:(NSNumber *)lat lon:(NSNumber *)lon floorID:(NSString *)floorID {

    LLLatLng *latLng = [[LLLatLng alloc] initWithLat:lat lng:lon];
    NSDictionary *locationDict = @{@"latLng": latLng,
                                   @"errorRadius": @(1),
                                   @"floorId": floorID,
                                   @"heading": @(130)};
    
    return locationDict;
}

- (void)postUserPosition:(NSDictionary *)locationDict {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_POSITION_SENSOR_POSITION_CHANGED
                                                        object:nil
                                                      userInfo:locationDict];
}

#pragma mark Delegates - LLVenueDatabase

- (void)venueDatabase:(LLVenueDatabase *)venueDatabase venueLoadFailed:(NSString *)venueId code:(LLDownloaderError)errorCode message:(NSString *)message {

    // Handle failures here
}

#pragma mark Delegates - LLMapView

- (void)mapViewDidClickBack:(LLMapView *)mapView {
    
    // The user tapped the "Cancel" button while the map was loading. Dismiss the app or take other appropriate action here
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)mapViewReady:(LLMapView *)mapView {
    
    // Set the navigation source to internal & send timed navigation points
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SET_POSITIONING_SENSOR_ALGORITHM
                                                        object:nil
                                                      userInfo:@{@"positioningSensorAlgorithm":@(LLPositioningSensorAlgorithmExternal)}];
    
    // Position 1 (Initial - DFS Duty Free)
    NSDictionary *locationDict = [self locationDictWithLat:@33.941485 lon:@-118.40195 floorID:@"lax-south-departures"];
    [self performSelector:@selector(postUserPosition:) withObject:locationDict afterDelay:1.0];
    
    // Position 2 (2 secs later)
    locationDict = [self locationDictWithLat:@33.941398 lon:@-118.401916 floorID:@"lax-south-departures"];
    [self performSelector:@selector(postUserPosition:) withObject:locationDict afterDelay:2.0];
    
    // Position 3 (4 secs later)
    locationDict = [self locationDictWithLat:@33.941283 lon:@-118.401863 floorID:@"lax-south-departures"];
    [self performSelector:@selector(postUserPosition:) withObject:locationDict afterDelay:4.0];
    
    // Position 4 (6 secs later)
    locationDict = [self locationDictWithLat:@33.941102 lon:@-118.401902 floorID:@"lax-south-departures"];
    [self performSelector:@selector(postUserPosition:) withObject:locationDict afterDelay:6.0];
    
    // Position 5 (8 secs later - Destination - Gate 64B)
    locationDict = [self locationDictWithLat:@33.940908 lon:@-118.40177 floorID:@"lax-south-departures"];
    [self performSelector:@selector(postUserPosition:) withObject:locationDict afterDelay:8.0];
}

- (UIViewController *)presentingControllerForMapView:(LLMapView *)mapView forContext:(LLMapViewPresentationContext)context {
    
    // Return a viewcontroller the SDK can use to present alerts
    return self;
}

@end
