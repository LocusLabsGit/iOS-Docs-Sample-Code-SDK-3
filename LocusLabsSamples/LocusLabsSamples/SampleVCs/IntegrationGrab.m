//
//  IntegrationGrab.m
//  IntegrationGRAB
//
//  Copyright © 2018 LocusLabs. All rights reserved.
//

#import "IntegrationGrab.h"

@interface IntegrationGrab ()

@property (nonatomic, strong) LLVenue           *venue;
@property (nonatomic, strong) LLVenueDatabase   *venueDatabase;
@property (nonatomic, weak)   LLMapView         *mapView;

@end

@implementation IntegrationGrab

// NB - You may need to run "pod update" before running this code

#pragma mark Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Initialize the SDK with the accountId provided
    [LLLocusLabs setup].accountId = @"A11F4Y6SZRXH4X";
    
    self.navigationController.navigationBar.hidden = YES;
    
    // The grab customer id is for testing purposes only and cannot be used in production
    [LLLocusLabs setup].grabCustomerId = @"abc2e5a1cdcebc486a6710b484aeaf9d";
    [LLLocusLabs setup].grabNavigationController = self.navigationController;
    
    // Optional - Only uncomment if you wish to customize the grab interface - see docs for available keys
    // [LLLocusLabs setup].grabStyleDictionary = @{};
    
    // Create a new LLMapView, register as its delegate and add it as a subview
    LLMapView *mapView = [[LLMapView alloc] initWithFrame:self.view.bounds];
    mapView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    mapView.delegate = self;
    [self.view addSubview:mapView];
    
    self.mapView = mapView;
    self.mapView.showTopSafeAreaOverlay = NO;
    
    // Get an instance of LLVenueDatabase, set it's mapview and register as its delegate
    self.venueDatabase = [LLVenueDatabase venueDatabaseWithMapView:self.mapView];
    self.venueDatabase.delegate = self;
    
    // Load the venue LAX async
    [self.venueDatabase loadVenueAndMap:@"lax" block:^(LLVenue *venue, LLMap *map, LLFloor *floor, LLMarker *marker) {
        
        self.venue = venue;
    }];
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
    
    return self;
}

@end
