//
//  SearchCategories.m


//  Copyright © 2021 Atrius, part of Acuity Brands. All rights reserved.
//

#import "SearchCategories.h"
#import <LocusLabsSDK/LocusLabsSDK.h>

@interface SearchCategories () <LLMapViewDelegate, LLVenueDatabaseDelegate>

@property (nonatomic, weak)   LLMapView         *mapView;
@property (nonatomic, strong) LLSearch          *seach;
@property (nonatomic, strong) LLVenue           *venue;
@property (nonatomic, strong) LLVenueDatabase   *venueDatabase;

@end

@implementation SearchCategories


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
        self.seach = [self.venue search];
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

- (void)performGeneralSearchForPOIsInEatCategory {
 
    [self.seach search:@"category:eat" completion:^(LLSearchResults *searchResults) {
        
        NSLog(@"category:eat Search Results count:%li", [[searchResults results] count]);
        
        for (LLSearchResult *searchResult in searchResults.results) {

            [self createCircleWithPosition:searchResult.position radius:@10 color:[UIColor magentaColor]];
        }
    }];
}

- (void)performSpecificSearchForPOIsInGateCategory {
    
    [self.seach search:@"gate:64" completion:^(LLSearchResults *searchResults) {
        
        NSLog(@"gate:64 Search Results count:%li", [[searchResults results] count]);
        
        for (LLSearchResult *searchResult in searchResults.results) {
            
            [self createCircleWithPosition:searchResult.position radius:@10 color:[UIColor magentaColor]];
        }
    }];
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
    
    // Perform a search for all POIs that belong to the Eat category
   // [self performGeneralSearchForPOIsInEatCategory];

    // Perform a specific search within the Gate category
    [self performSpecificSearchForPOIsInGateCategory];
}

- (UIViewController *)presentingControllerForMapView:(LLMapView *)mapView forContext:(LLMapViewPresentationContext)context {
    
    // Return a viewcontroller the SDK can use to present alerts
    return self;
}

@end
