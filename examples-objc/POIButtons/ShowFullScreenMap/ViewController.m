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
    }];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
    [super traitCollectionDidChange:previousTraitCollection];
    
    self.mapView.darkMode = self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
}

#pragma mark Delegates - LLVenueDatabase

- (void)venueDatabase:(LLVenueDatabase *)venueDatabase venueLoadFailed:(NSString *)venueId code:(LLDownloaderError)errorCode message:(NSString *)message {

    // Handle failures here
}

#pragma mark Delegates - LLMapView

- (NSArray *)mapView:(LLMapView *)mapView additionalViewsForPOI:(NSString *)poiId {
    
    NSMutableArray *additionalViews = [NSMutableArray array];
    
    // Only add extra buttons for the Starbucks POI at Gate 60
    if ([poiId isEqualToString:@"870"]) {
    
        LLIconButton *button1 = [LLIconButton topIconButtonWithPadding:0 image:[UIImage imageNamed:@"custom_icon_1.png"] andLabel:@"Custom1"];
        [additionalViews addObject:button1];
        
        [button1 addTarget:self action:@selector(customPoiButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return additionalViews;
}

- (void)customPoiButtonTapped {
    
    NSLog(@"Custom POI Button tapped");
}

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


@end
