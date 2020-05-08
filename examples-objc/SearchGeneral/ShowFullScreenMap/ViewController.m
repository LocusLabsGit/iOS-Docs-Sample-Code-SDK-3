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
@property (nonatomic, strong) LLSearch          *search;
@property (nonatomic, strong) LLVenue           *venue;
@property (nonatomic, strong) LLVenueDatabase   *venueDatabase;

@end

@implementation ViewController

// NB - You may need to run "pod update" before running this code

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
        self.search = [self.venue search];
    }];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
    [super traitCollectionDidChange:previousTraitCollection];
    
    self.mapView.darkMode = self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
}

#pragma mark Custom

- (void)createCircleWithPosition:(LLPosition *)position radius:(NSNumber*)radius color:(UIColor*)color {
    
    LLCircle *circle = [LLCircle new];
    circle.fillColor = color;
    circle.radius = radius;
    circle.position = position;
    circle.map = self.mapView.map;
}

- (void)generalSearchForTerm:(NSString *)searchTerm {
    
    [self.search search:searchTerm completion:^(LLSearchResults *searchResults) {
        
        NSMutableArray *resultPOIIDs = [NSMutableArray array];
        
        // Show results on the map
        for (LLSearchResult *searchResult in searchResults.results) {
            
            [self createCircleWithPosition:searchResult.position radius:@10 color:[UIColor redColor]];
            [resultPOIIDs addObject:searchResult.poiId];
        }
        
        // Get some more data on each result
        [self.venue.poiDatabase loadPois:resultPOIIDs withBlock:^(NSArray *pois) {
           
            for (LLPOI *poi in pois) {
                
                NSLog(@"Name:%@", poi.name);
                NSLog(@"Position:%@", poi.position);
            }
        }];
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
    
    [self generalSearchForTerm:@"restaurant"];
}

- (UIViewController *)presentingControllerForMapView:(LLMapView *)mapView forContext:(LLMapViewPresentationContext)context {
    
    // Return a viewcontroller the SDK can use to present alerts
    return self;
}

@end
