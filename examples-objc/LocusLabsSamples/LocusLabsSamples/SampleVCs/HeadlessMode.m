//
//  HeadlessMode.m
//  Copyright © 2020 LocusLabs. All rights reserved.
//

#import "HeadlessMode.h"
#import <LocusLabsSDK/LocusLabsSDK.h>

@interface HeadlessMode () <LLVenueDatabaseDelegate>

@property (nonatomic, strong) LLVenue           *venue;
@property (nonatomic, strong) LLVenueDatabase   *venueDatabase;

@end

@implementation HeadlessMode


#pragma mark Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [LLLocusLabs setup].accountId = @"A11F4Y6SZRXH4X";
    
    // Get an instance of LLVenueDatabase, set it's mapview and register as its delegate
    self.venueDatabase = [LLVenueDatabase venueDatabase];
    self.venueDatabase.delegate = self;
    
    [self.venueDatabase loadVenue:@"lax"];
}

#pragma mark Delegates - LLVenueDatabase

- (void)venueDatabase:(LLVenueDatabase *)venueDatabase venueLoaded:(LLVenue *)venue {
    
    // Venue ready to use
    NSLog(@"Venue loaded and ready to use");
}

- (void)venueDatabase:(LLVenueDatabase *)venueDatabase venueLoadFailed:(NSString *)venueId code:(LLDownloaderError)errorCode message:(NSString *)message {

    // Handle failures here
}


@end
