//
//  HeadlessMode.swift
//  LocusLabsSamplesSwift
//
//  Created by Juan Kruger on 27/09/2022.
//  Copyright © 2022 LocusLabs. All rights reserved.
//


import UIKit

class HeadlessMode: UIViewController, LLVenueDatabaseDelegate {

    // Vars
    var venueDatabase:      LLVenueDatabase!
    var venue:              LLVenue?
    var mapView:            LLMapView?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Initialize the SDK with the accountId provided
        LLLocusLabs.setup().accountId = "A11F4Y6SZRXH4X"
        
        // Get an instance of LLVenueDatabase and register as its delegate
        venueDatabase = LLVenueDatabase()
        venueDatabase.delegate = self
                
        // Load the venue LAX async
        venueDatabase.loadVenue("lax")
    }
    
    // MARK: Delegates - LLVenueDatabase
    func venueDatabase(_ venueDatabase: LLVenueDatabase!, venueLoadCompleted venueId: String!) {
        
        // Venue ready to use
    }
    
    func venueDatabase(_ venueDatabase: LLVenueDatabase!, venueLoaded venue: LLVenue!) {
            
        self.venue = venue
    }
    
    func venueDatabase(_ venueDatabase: LLVenueDatabase!, venueLoadFailed venueId: String!, code errorCode: LLDownloaderError, message: String!) {
        
        // Handle failures here
    }
}


