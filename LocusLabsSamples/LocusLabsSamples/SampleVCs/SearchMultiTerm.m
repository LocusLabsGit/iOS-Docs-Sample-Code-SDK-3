//
//  SearchMultiTerm.m


//  Copyright © 2021 Atrius, part of Acuity Brands. All rights reserved.
//

#import "SearchMultiTerm.h"
#import <LocusLabsSDK/LocusLabsSDK.h>

@interface SearchMultiTerm () <LLMapViewDelegate, LLVenueDatabaseDelegate, LLSearchDelegate>

@property (nonatomic, weak)   LLMapView         *mapView;
@property (nonatomic, strong) LLSearch          *search;
@property (nonatomic, strong) LLVenue           *venue;
@property (nonatomic, strong) LLVenueDatabase   *venueDatabase;

@end

@implementation SearchMultiTerm


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
        self.search.delegate = self;
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

- (void)performANDSearch {
    
    [self.search multiTermSearch:@[@"Beer", @"Burger"]];
}

- (void)performORSearch {
    
    [self.search searchWithTerms:@[@"Beer", @"Burger"]];
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
    
    // Perform a search for all POIs that match Beer AND Burger
    [self performANDSearch];
    
    // Perform a search for all POIs that match either Beer OR Burger
   // [self performORSearch];
}

- (UIViewController *)presentingControllerForMapView:(LLMapView *)mapView forContext:(LLMapViewPresentationContext)context {
    
    // Return a viewcontroller the SDK can use to present alerts
    return self;
}

#pragma mark Delegates - LLSearch

- (void)search:(LLSearch *)search multiTermSearchResults:(LLMultiTermSearchResults *)searchResults {
    
    NSLog(@"AND Search Result count:%li", searchResults.results.count);
    
    for (LLSearchResult *searchResult in searchResults.results) {
        
        [self createCircleWithPosition:searchResult.position radius:@10 color:[UIColor greenColor]];
    }
}

- (void)searchWithTerms:(LLSearch *)search results:(LLSearchResults *)searchResults {
    
    NSLog(@"OR Search Result count:%li", searchResults.results.count);
    
    for (LLSearchResult *searchResult in searchResults.results) {
        
        [self createCircleWithPosition:searchResult.position radius:@10 color:[UIColor greenColor]];
    }
}

@end
