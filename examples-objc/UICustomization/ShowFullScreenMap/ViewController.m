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
    
    // Custon UI Theming
    //[self updateUIFonts];
    [self updateUIColors];
    
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

- (void)updateUIColors {
    
    LLThemeBuilder *themeBuilder = [LLThemeBuilder themeBuilderWithTheme:[LLTheme defaultTheme]]; // Call darkTheme to edit the darkmode theme
    
    // Change icon colors in the search bar
    [themeBuilder setProperty:@"colors.global/SecondaryText" value:[UIColor orangeColor]];
    
    // Change the action bar item text (coffee, bars, etc.)
    [themeBuilder setProperty:@"colors.global/PrimaryText" value:[UIColor grayColor]];
    
    self.mapView.theme = themeBuilder.theme;
    
    // If you have implemented dark mode, you need to set the theme as follows for that mode
    // [self.mapView setDarkMode:YES theme:darkThemeBuilder.theme];
}

- (void)updateUIFonts {
    
    UIFont *customFont = [UIFont fontWithName:@"American Typewriter" size:16.0];
    
    LLThemeBuilder *themeBuilder = [LLThemeBuilder themeBuilderWithTheme:[LLTheme defaultTheme]]; // Call darkTheme to edit the darkmode theme

    // This updates the search bar placeholder text and other places where the original font was used
    [themeBuilder setProperty:@"fonts.H2_Regular" value:customFont];
    
    // This updates the action bar text and other places where the original font was used
    [themeBuilder setProperty:@"fonts.H3_Semibold" value:customFont];
 
    self.mapView.theme = themeBuilder.theme;
    
    // If you have implemented dark mode, you need to set the theme as follows for that mode
    // [self.mapView setDarkMode:YES theme:darkThemeBuilder.theme];
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

@end
