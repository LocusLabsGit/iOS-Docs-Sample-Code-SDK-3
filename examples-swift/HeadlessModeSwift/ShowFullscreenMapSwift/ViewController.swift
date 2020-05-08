//
//  ViewController.swift
//  ShowFullscreenMapSwift
//
//  Created by Juan Kruger on 2020/05/06.
//  Copyright © 2020 LocusLabs. All rights reserved.
//

import UIKit

// NB - You may need to run "pod update" before running this code

class ViewController: UIViewController, LLVenueDatabaseDelegate {

    // Vars
    var venueDatabase:      LLVenueDatabase!
    var venue:              LLVenue?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Initialize the LocusLabs SDK with the accountId provided by LocusLabs
        LLLocusLabs.setup().accountId = "A11F4Y6SZRXH4X"
        
        // Get an instance of LLVenueDatabase and register as its delegate
        venueDatabase = LLVenueDatabase()
        venueDatabase.delegate = self
        
        // Load the venue LAX async
        venueDatabase.loadVenue("lax")
    }
    
    // MARK: Delegates - LLVenueDatabase
    func venueDatabase(_ venueDatabase: LLVenueDatabase!, venueLoaded venue: LLVenue!) {
        
        // Venue ready to use
        print("Venue loaded and ready to use")
    }
    
    func venueDatabase(_ venueDatabase: LLVenueDatabase!, venueLoadFailed venueId: String!, code errorCode: LLDownloaderError, message: String!) {
        
        // Handle failures here
    }
}

