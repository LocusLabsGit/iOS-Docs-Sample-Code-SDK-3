//
//  Markers.m

//  Copyright © 2021 Atrius, part of Acuity Brands. All rights reserved.
//

#import "Markers.h"
#import <LocusLabsSDK/LocusLabsSDK.h>

@interface Markers () <LLMapViewDelegate, LLVenueDatabaseDelegate>

@property (nonatomic, strong) NSMutableArray    *customMarkers;
@property (nonatomic, weak)   LLMapView         *mapView;
@property (nonatomic, strong) LLVenue           *venue;
@property (nonatomic, strong) LLVenueDatabase   *venueDatabase;

@end

@implementation Markers


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

- (void)addMarker {
    
    // The poi id for Starbucks near Gate 60 is 870
    [self.venue.poiDatabase loadPois:@[@"870"] withBlock:^(NSArray *pois) {
       
        LLPOI *starbucksPOI = nil;
        for (LLPOI *poi in pois) {
            
            if ([poi.poiId isEqualToString:@"870"]) starbucksPOI = poi;
        }
        
        if (starbucksPOI) {
            NSLog(@"a1");
            // Add a custom marker
            LLMarker *marker = [[LLMarker alloc] init];
            marker.position = starbucksPOI.position;
            marker.iconUrl = [[NSBundle mainBundle] pathForResource:@"starbucks" ofType:@"png"];
            marker.userData = starbucksPOI;
            marker.map = self.mapView.map;
            
            // Keep a reference to the marker so you can remove it when necessary
            if (!self.customMarkers) self.customMarkers = [NSMutableArray array];
            [self.customMarkers addObject:marker];
        }
    }];
}

- (void)removeMarker {
    
    LLMarker *marker = [self.customMarkers firstObject];
    marker.map = nil;
    [self.customMarkers removeObject:marker];
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

- (BOOL)mapView:(LLMapView *)mapView didTapMarker:(LLMarker *)marker {

    NSLog(@"Marker tapped with ID:%@", ((LLPOI*)(marker.userData)).poiId);
    // Return no to let the SDK handle the tap. If you would like to handle the tap, return YES
    return NO;
}

- (void)mapViewReady:(LLMapView *)mapView {
    
    [self addMarker];
}

- (NSString *)mapView:(LLMapView *)mapView markerIconUrlForPOI:(LLPOI *)poi {
    
    if ([poi.poiId isEqualToString:@"869"]) return [[NSBundle mainBundle] pathForResource:@"newspaper_icon" ofType:@"png"];
    
    return nil;
}

- (UIViewController *)presentingControllerForMapView:(LLMapView *)mapView forContext:(LLMapViewPresentationContext)context {
    
    // Return a viewcontroller the SDK can use to present alerts
    return self;
}

@end
