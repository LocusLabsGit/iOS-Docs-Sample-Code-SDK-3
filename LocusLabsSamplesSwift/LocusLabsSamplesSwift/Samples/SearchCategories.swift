//

//  Copyright © 2021 Atrius, part of Acuity Brands. All rights reserved.
//

import UIKit

// NB - You may need to run "pod update" before running this code

class SearchCategories: UIViewController, LLVenueDatabaseDelegate, LLMapViewDelegate {

    // Vars
    var venueDatabase:      LLVenueDatabase!
    var venue:              LLVenue?
    var mapView:            LLMapView?
    var search:             LLSearch!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Initialize the SDK with the accountId provided
        LLLocusLabs.setup().accountId = "A11F4Y6SZRXH4X"
        
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
        venueDatabase.loadVenueAndMap("lax") { (_venue: LLVenue?, _map: LLMap?, _floor: LLFloor?, _marker: LLMarker?) in
            
            self.venue = _venue
            self.search = self.venue?.search()!
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        
        mapView?.darkMode = traitCollection.userInterfaceStyle == .dark
    }
    
    // MARK: Custom
    func createCircle(position: LLPosition, radius: Float, color: UIColor) {
        
        let circle = LLCircle()
        circle.position = position
        circle.fillColor = color
        circle.radius = radius as NSNumber
        circle.map = mapView?.map
    }
    
    func performGeneralSearchForPOIsInEatCategory() {
        
        search.search("category:eat") { searchResults in
            
            for searchResult in searchResults?.results as! [LLSearchResult] {
                
                self.createCircle(position: searchResult.position, radius: 10, color: .magenta)
            }
        }
    }
    
    func performSpecificSearchForPOIsInGateCategory() {
        
        search.search("gate:64") { searchResults in
            
            for searchResult in searchResults?.results as! [LLSearchResult] {
                
                self.createCircle(position: searchResult.position, radius: 10, color: .magenta)
            }
        }
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
        
        // Perform a search for all POIs that belong to the Eat category
        //performGeneralSearchForPOIsInEatCategory()

        // Perform a specific search within the Gate category
        performSpecificSearchForPOIsInGateCategory();
    }
    
    func presentingController(for mapView: LLMapView!, for context: LLMapViewPresentationContext) -> UIViewController! {
        
        // Return a viewcontroller the SDK can use to present alerts
        return self
    }
}

