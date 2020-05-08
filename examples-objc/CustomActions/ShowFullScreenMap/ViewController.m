//
//  ViewController.m
//  ShowFullScreenMap
//
//  Created by Juan Kruger on 2020/04/22.
//  Copyright © 2020 LocusLabs. All rights reserved.
//

#import "ViewController.h"
#import <LocusLabsSDK/LocusLabsSDK.h>

@interface ViewController () <LLMapViewDelegate, LLVenueDatabaseDelegate>

@property (nonatomic, weak)   LLMapView         *mapView;
@property (nonatomic, strong) LLVenue           *venue;
@property (nonatomic, strong) LLVenueDatabase   *venueDatabase;

@end

@implementation ViewController

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

- (NSArray *)customActions {

    NSMutableArray *customActions = [NSMutableArray array];

    // Create a custom action to show a POI e.g. POI 519 is gate 68A at lax
    LLPlaceUI *ui = [LLPlaceUI defaultUI];
    ui.icon = @"map-icon-airports.png"; // Supply any solid fill png. This one chosen as it is already in the bundle - you can supply your own
    ui.normalIconColor = [UIColor orangeColor];

    LLPlace *customPOIAction = [[LLPlace alloc] initWithBehavior:LLPlaceBehaviorPOI values:@[@"519"] displayName:@"Departure Gate" andUI:ui];
    [customActions addObject:customPOIAction];
    
    // Create a custom action to trigger a search
    LLPlaceUI *uiSearch = [LLPlaceUI defaultUI];
    uiSearch.icon = @"map-icon-search.png"; // Supply any solid fill png. This one chosen as it is already in the bundle - you can supply your own
    uiSearch.normalIconColor = [UIColor whiteColor];
    uiSearch.marker = @"images/pin-plane-landing.svg"; // Supply any size-embedded svg of your choice. This is chosen as it is already in the bundle
    
    LLPlace *customSearchAction = [[LLPlace alloc] initWithBehavior:LLPlaceBehaviorSearch values:@[@"check-in"] displayName:@"Check-In" andUI:uiSearch];
    [customActions addObject:customSearchAction];
    
    return customActions;
}

#pragma mark Delegates - LLVenueDatabase

- (void)venueDatabase:(LLVenueDatabase *)venueDatabase venueLoadFailed:(NSString *)venueId code:(LLDownloaderError)errorCode message:(NSString *)message {

    // Handle failures here
}

#pragma mark Delegates - LLMapView

- (void)mapViewDidClickBack:(LLMapView *)mapView {
    
    // The user tapped the "Cancel" button while the map was loading. Dismiss the app or take other appropriate action here
}

- (void)mapViewReady:(LLMapView *)mapView {
    
    // The map is ready to be used in calls e.g. zooming, showing poi, etc.
}

- (UIViewController *)presentingControllerForMapView:(LLMapView *)mapView forContext:(LLMapViewPresentationContext)context {
    
    // Return a viewcontroller the SDK can use to present alerts
    return self;
}

- (NSArray *)mapView:(LLMapView *)mapView willPresentPlaces:(NSArray *)places {
    
    // Show no actions
    // return @[];
    
    // Show default actions
    // return places;
    
    // Show custom actions
    return [self customActions];
}

@end
