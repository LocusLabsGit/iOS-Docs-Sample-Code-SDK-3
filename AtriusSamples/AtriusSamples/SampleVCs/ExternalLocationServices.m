//
//  ExternalLocationServices.m

//
//  Copyright © 2021 Atrius, part of Acuity Brands. All rights reserved.
//

#import "ExternalLocationServices.h"
#import <LocusLabsSDK/LocusLabsSDK.h>
#import <LocusLabsSDK/LLConstants.h>

@interface ExternalLocationServices () <LLMapViewDelegate, LLVenueDatabaseDelegate>

@property (nonatomic, weak)   LLMapView         *mapView;
@property (nonatomic, strong) LLVenue           *venue;
@property (nonatomic, strong) LLVenueDatabase   *venueDatabase;

@end

@implementation ExternalLocationServices


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
        self.mapView.positionManager.activePositioning = NO;
        self.mapView.positionManager.passivePositioning = NO;
        
        // Set the navigation source to external
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SET_POSITIONING_SENSOR_ALGORITHM
                                                            object:nil
                                                          userInfo:@{@"positioningSensorAlgorithm":@(LLPositioningSensorAlgorithmExternal)}];
    }];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
    [super traitCollectionDidChange:previousTraitCollection];
    
    self.mapView.darkMode = self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
}

#pragma mark Custom

// This is a pseudomethod to demonstrate how data may be received from an external provider and how it can be passed to our SDK
- (void)didReceiveExternalLocationDict:(NSDictionary *)externalLocationDict {

    NSString *locusLabsFloorID = [self locusLabsFloorIDForExternalFloorID:externalLocationDict[@"FloorId"]];
    if (!locusLabsFloorID) return;
    
    NSDictionary *locationDict = [self locationDictWithLat:externalLocationDict[@"Lat"] lon:externalLocationDict[@"Lon"] floorId:locusLabsFloorID heading:nil];
    [self postUserPosition:locationDict];
}

- (NSDictionary *)locationDictWithLat:(NSNumber *)lat lon:(NSNumber *)lon floorId:(NSString *)floorId heading:(NSNumber *)heading {

    if (!heading) heading = @(180);
    
    LLLatLng *latLng = [[LLLatLng alloc] initWithLat:lat lng:lon];
    NSDictionary *locationDict = @{@"latLng": latLng,
                                   @"errorRadius": @(1),
                                   @"floorId": floorId,
                                   @"heading": heading}; // heading is optional
    
    return locationDict;
}

- (void)mockExternalLocationData {
    
    // Position 1 (Initial - DFS Duty Free)
    NSDictionary *locationDict = @{@"FloorId": @"T48L3", @"Lat": @33.941485, @"Lon": @-118.40195};
    [self performSelector:@selector(didReceiveExternalLocationDict:) withObject:locationDict afterDelay:1.0];
    
    // Position 2 (2 secs later)
    locationDict = @{@"FloorId": @"T48L3", @"Lat": @33.941398, @"Lon": @-118.401916};
    [self performSelector:@selector(didReceiveExternalLocationDict:) withObject:locationDict afterDelay:3.0];
    
    // Position 3 (4 secs later)
    locationDict = @{@"FloorId": @"T48L3", @"Lat": @33.941283, @"Lon": @-118.401863};
    [self performSelector:@selector(didReceiveExternalLocationDict:) withObject:locationDict afterDelay:5.0];

    // Position 4 (6 secs later)
    locationDict = @{@"FloorId": @"T48L3", @"Lat": @33.941102, @"Lon": @-118.401902};
    [self performSelector:@selector(didReceiveExternalLocationDict:) withObject:locationDict afterDelay:7.0];

    // Position 5 (8 secs later - Destination - Gate 64B)
    locationDict = @{@"FloorId": @"T48L3", @"Lat": @33.940908, @"Lon": @-118.40177};
    [self performSelector:@selector(didReceiveExternalLocationDict:) withObject:locationDict afterDelay:9.0];
}

- (void)postUserPosition:(NSDictionary *)locationDict {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_POSITION_SENSOR_POSITION_CHANGED
                                                        object:nil
                                                      userInfo:locationDict];
}

- (void)hideBlueDot {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_POSITION_CLEAR object:nil];
}

- (NSString *)locusLabsFloorIDForExternalFloorID:(NSString *)externalFloorId {
    
    NSString *locusLabsFloorId = nil;
    if ([externalFloorId isEqualToString:@"T48L3"]) locusLabsFloorId = @"lax-terminal6-departures";
    else if ([externalFloorId isEqualToString:@"???"]) locusLabsFloorId = @"???";
    else if ([externalFloorId isEqualToString:@"???"]) locusLabsFloorId = @"???";
        
    return locusLabsFloorId;
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
    
    // The map is ready to be used in calls e.g. zooming, showing poi, etc.
    [self mockExternalLocationData];
}

- (void)mapView:(LLMapView *)mapView didTapAtPosition:(LLPosition *)position {
    
    NSLog(@"floor:%@", position.floorId);
}

- (UIViewController *)presentingControllerForMapView:(LLMapView *)mapView forContext:(LLMapViewPresentationContext)context {
    
    // Return a viewcontroller the SDK can use to present alerts
    return self;
}

@end
