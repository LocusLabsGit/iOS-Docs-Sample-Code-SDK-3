//

//  Copyright © 2021 Atrius, part of Acuity Brands. All rights reserved.
//

import UIKit

// NB - You may need to run "pod update" before running this code

class DirectionsUI: UIViewController, LLVenueDatabaseDelegate, LLMapViewDelegate {

    // Vars
    var venueDatabase:      LLVenueDatabase!
    var venue:              LLVenue?
    var mapView:            LLMapView?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Initialize the SDK with the accountId provided
        //LLLocusLabs.setup().accountId = "A11F4Y6SZRXH4X"//ll
        LLLocusLabs.setup().accountId = "A1JBKAEKZ89XDX"
        
        // Create a new LLMapView, register as its delegate and add it as a subview
        mapView = LLMapView(frame: view.bounds)
        mapView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView?.delegate = self
        view.addSubview(mapView!)
        
        mapView?.showTopSafeAreaOverlay = false
        mapView?.darkMode = traitCollection.userInterfaceStyle == .dark
        
        // Get an instance of LLVenueDatabase, register as its delegate and load the venue LAX
        venueDatabase = LLVenueDatabase(mapView: mapView)
        venueDatabase.delegate = self
        
        // Load the venue LAX async
        venueDatabase.loadVenueAndMap("lhr") { (_venue: LLVenue?, _map: LLMap?, _floor: LLFloor?, _marker: LLMarker?) in
            
            self.venue = _venue
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        
        mapView?.darkMode = traitCollection.userInterfaceStyle == .dark
    }
    
    // MARK: Custom
    func showSampleRoute() {
        
        // Start: Blu20 Bar, Terminal 6, Level 3, ID 1025
        // End: Gate 77, Terminal 7, Level 3, ID 566
        venue?.poiDatabase()?.loadPois(["1025", "298743"], with: { pois in
            
            var startPOI: LLPOI?
            var endPOI: LLPOI?
            
            for poi in pois as! [LLPOI] {
                
                if poi.poiId == "1025" {startPOI = poi}
                else if poi.poiId == "566" {endPOI = poi}
            }
            
            if startPOI != nil && endPOI != nil {
                
                self.mapView?.openNavigationView(withStart: startPOI?.position, andEnd: endPOI?.position)
            }
        })
    }
    
    // MARK: Delegates - LLVenueDatabase
    func venueDatabase(_ venueDatabase: LLVenueDatabase!, venueLoadFailed venueId: String!, code errorCode: LLDownloaderError, message: String!) {
        
        // Handle failures here
    }
    
    // MARK: Delegates - LLMapView
    func mapViewDidClickBack(_ mapView: LLMapView!) {
        
        // The user tapped the "Cancel" button while the map was loading. Dismiss the app or take other appropriate action here
        navigationController?.popViewController(animated: true)
    }
    
    func mapViewReady(_ mapView: LLMapView!) {
        
        showSampleRoute()
    }
    
    func presentingController(for mapView: LLMapView!, for context: LLMapViewPresentationContext) -> UIViewController! {
        
        // Return a viewcontroller the SDK can use to present alerts
        return self
    }
}

