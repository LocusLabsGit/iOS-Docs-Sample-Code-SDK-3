//
//  ViewController.m
//  LocusLabsSamples
//
//  Copyright © 2020 LocusLabs. All rights reserved.
//

#import "ViewController.h"
#import "ShowFullscreenMap.h"
#import "ShowEmbeddedMap.h"
#import "BundledMap.h"
#import "CustomActions.h"
#import "DirectionsRequested.h"
#import "DirectionsStepsETA.h"
#import "DirectionsUI.h"
#import "ExternalLocationServices.h"
#import "HeadlessMode.h"
#import "MapBasics.h"
#import "Markers.h"
#import "POIButtons.h"
#import "POIShow.h"
#import "RecommendedSearches.h"
#import "SearchAutoDisplay.h"
#import "SearchCategories.h"
#import "SearchGeneral.h"
#import "SearchMultiTerm.h"
#import "SearchProximity.h"
#import "UICustomization.h"
#import "UserLocationSimulated.h"
#import "UserLocationTracking.h"
#import "VenueData.h"
#import "IntegrationGrab.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *samples;

@end

@implementation ViewController {
    
}
// *********************************************************************************************
// NB - You may need to run "pod update" before running this code
// *********************************************************************************************

#pragma mark Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"LocusLabs Samples";
    
    self.samples = @[@"Fullscreen Map", @"Embedded Map", @"Bundled Map", @"Custom Actions", @"Directions Requested", @"Directions - Steps & ETA",
                    @"Directions UI", @"External Location Services", @"GRAB Integration", @"Map Basics", @"Markers", @"POI Buttons", @"POI Show",
                    @"Recommended Searches", @"Search Auto Display", @"Search Categories", @"Search General", @"Search Multiterm", @"Search Proximity",
                    @"UI Customization", @"User Location Simulated", @"User Location Tracking", @"Venue Data"];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

#pragma mark Delegates - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.samples count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    cell.textLabel.text = self.samples[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *sample = self.samples[indexPath.row];
    UIViewController *vcToShow = nil;
    
    if ([sample isEqualToString:@"Fullscreen Map"]) vcToShow = [ShowFullscreenMap new];
    else if ([sample isEqualToString:@"Embedded Map"]) vcToShow = [ShowEmbeddedMap new];
    else if ([sample isEqualToString:@"Bundled Map"]) vcToShow = [BundledMap new];
    else if ([sample isEqualToString:@"Custom Actions"]) vcToShow = [CustomActions new];
    else if ([sample isEqualToString:@"Directions Requested"]) vcToShow = [DirectionsRequested new];
    else if ([sample isEqualToString:@"Directions - Steps & ETA"]) vcToShow = [DirectionsStepsETA new];
    else if ([sample isEqualToString:@"Directions UI"]) vcToShow = [DirectionsUI new];
    else if ([sample isEqualToString:@"External Location Services"]) vcToShow = [ExternalLocationServices new];
    else if ([sample isEqualToString:@"GRAB Integration"]) vcToShow = [IntegrationGrab new];
    else if ([sample isEqualToString:@"Map Basics"]) vcToShow = [MapBasics new];
    else if ([sample isEqualToString:@"Markers"]) vcToShow = [Markers new];
    else if ([sample isEqualToString:@"POI Buttons"]) vcToShow = [POIButtons new];
    else if ([sample isEqualToString:@"POI Show"]) vcToShow = [POIShow new];
    else if ([sample isEqualToString:@"Recommended Searches"]) vcToShow = [RecommendedSearches new];
    else if ([sample isEqualToString:@"Search Auto Display"]) vcToShow = [SearchAutoDisplay new];
    else if ([sample isEqualToString:@"Search Categories"]) vcToShow = [SearchCategories new];
    else if ([sample isEqualToString:@"Search General"]) vcToShow = [SearchGeneral new];
    else if ([sample isEqualToString:@"Search Multiterm"]) vcToShow = [SearchMultiTerm new];
    else if ([sample isEqualToString:@"Search Proximity"]) vcToShow = [SearchProximity new];
    else if ([sample isEqualToString:@"UI Customization"]) vcToShow = [UICustomization new];
    else if ([sample isEqualToString:@"User Location Simulated"]) vcToShow = [UserLocationSimulated new];
    else if ([sample isEqualToString:@"User Location Tracking"]) vcToShow = [UserLocationTracking new];
    else if ([sample isEqualToString:@"Venue Data"]) vcToShow = [VenueData new];
    
    [self.navigationController pushViewController:vcToShow animated:nil];
}

@end
