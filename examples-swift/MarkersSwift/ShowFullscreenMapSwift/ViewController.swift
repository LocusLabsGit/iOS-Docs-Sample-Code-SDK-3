//
//  ViewController.swift
//  ShowFullscreenMapSwift
//
//  Created by Juan Kruger on 2020/05/06.
//  Copyright © 2020 LocusLabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LLVenueDatabaseDelegate, LLMapViewDelegate {

    // Vars
    var customMarkers =     [LLMarker]()
    var venueDatabase:      LLVenueDatabase!
    var venue:              LLVenue?
    var mapView:            LLMapView?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Initialize the LocusLabs SDK with the accountId provided by LocusLabs
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
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        
        mapView?.darkMode = traitCollection.userInterfaceStyle == .dark
    }
    
    // MARK: Custom
    func addMarker() {
        
        venue?.poiDatabase()?.loadPois(["870"], with: { pois in
            
            var starbucksPOI: LLPOI?
            
            for poi in pois as! [LLPOI] {
                
                if poi.poiId == "870" {starbucksPOI = poi}
            }
            
            if starbucksPOI != nil {
                
                // Add a custom marker
                let marker = LLMarker()
                marker.position = starbucksPOI?.position
                marker.iconUrl = Bundle.main.path(forResource: "starbucks", ofType: "png")
                marker.userData = starbucksPOI
                marker.map = self.mapView?.map
                
                // Keep a reference to the marker so you can remove it when necessary
                self.customMarkers.append(marker)
            }
        })
    }
    
    func removeMarker() {
        
        if customMarkers.count > 0 {
            
            let marker = customMarkers[0]
            marker.map = nil
            customMarkers.remove(at: 0)
        }
    }
    
    // MARK: Delegates - LLVenueDatabase
    func venueDatabase(_ venueDatabase: LLVenueDatabase!, venueLoadFailed venueId: String!, code errorCode: LLDownloaderError, message: String!) {
        
        // Handle failures here
    }
    
    // MARK: Delegates - LLMapView
    func mapViewDidClickBack(_ mapView: LLMapView!) {
        
        // The user tapped the "Cancel" button while the map was loading. Dismiss the app or take other appropriate action here
    }
    
    func mapView(_ mapView: LLMapView!, didTap marker: LLMarker!) -> Bool {
        
        if let poi = marker.userData! as? LLPOI {
        
            print("Marker tapped with ID:", poi.poiId!)
        }
        
        // Return false to let the SDK handle the tap. If you would like to handle the tap, return true
        return false
    }
    
    func mapViewReady(_ mapView: LLMapView!) {
        
        addMarker()
    }
    
    func presentingController(for mapView: LLMapView!, for context: LLMapViewPresentationContext) -> UIViewController! {
        
        // Return a viewcontroller the SDK can use to present alerts
        return self
    }
}

