//
//  VenueData.m


//  Copyright © 2021 Atrius, part of Acuity Brands. All rights reserved.
//

#import "VenueData.h"
#import <LocusLabsSDK/LocusLabsSDK.h>

@interface VenueData () <LLMapViewDelegate, LLVenueDatabaseDelegate>

@property (nonatomic, weak)   LLMapView         *mapView;
@property (nonatomic, strong) LLVenue           *venue;
@property (nonatomic, strong) LLVenueDatabase   *venueDatabase;

@end

@implementation VenueData

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
    [self.venueDatabase listVenues];
    
    [self.venueDatabase loadVenueAndMap:@"lax" block:^(LLVenue *venue, LLMap *map, LLFloor *floor, LLMarker *marker) {
        
        self.venue = venue;
        
        [self listBuildingsAndFloors];
        [self loadPOIs];
    }];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
    [super traitCollectionDidChange:previousTraitCollection];
    
    self.mapView.darkMode = self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
}

#pragma mark Custom

- (void)listBuildingsAndFloors {
    
    for (LLBuilding *building in self.venue.buildings) {
        
        NSLog(@"Building name:%@", building.name);
        NSLog(@"Building id:%@", building.buildingId);
        
        for (LLFloor *floor in building.floors) {
            
            NSLog(@"Floor level:%@", floor.ordinal);
            NSLog(@"Floor id:%@", floor.floorId);
        }
    }
}

- (void)loadPOIs {
    
    // This loads all POIs. You could also use "loadPOIs:withBlock" to load only specific pois
    [self.venue.poiDatabase loadAllPois:^(NSArray *pois) {
        
        for (LLPOI *poi in pois) {
            
            NSLog(@"Name:%@", poi.name);
            NSLog(@"ID:%@", poi.poiId);
            NSLog(@"Position:%@", poi.position);
        }
    }];
}

- (void)loadPOIWithID:(NSString *)poiID {
    
    [self.venue.poiDatabase loadPois:@[poiID] withBlock:^(NSArray *pois) {
        
        for (LLPOI *poi in pois) {
            
            NSLog(@"Name:%@", poi.name);
            NSLog(@"ID:%@", poi.poiId);
            NSLog(@"Position:%@", poi.position);
        }
    }];
}

#pragma mark Delegates - LLVenueDatabase

- (void)venueDatabase:(LLVenueDatabase *)venueDatabase venueList:(NSArray *)venueList {
    
    for (LLVenueInfo *venueInfo in venueList) {
        
        NSString *airportCode = ([venueInfo.venueId length] > 3 ? [venueInfo.venueId substringToIndex:3] : venueInfo.venueId);
        NSLog(@"Venue name:%@", venueInfo.name);
        NSLog(@"Venue id:%@", venueInfo.venueId);
        NSLog(@"Airport code:%@", airportCode);
    }
}

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
}

- (UIViewController *)presentingControllerForMapView:(LLMapView *)mapView forContext:(LLMapViewPresentationContext)context {
    
    // Return a viewcontroller the SDK can use to present alerts
    return self;
}

@end
