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
        venueDatabase.listVenues()
        
        // Load the venue LAX async
        venueDatabase.loadVenueAndMap("lax") { (_venue: LLVenue?, _map: LLMap?, _floor: LLFloor?, _marker: LLMarker?) in
            
            self.venue = _venue
            self.listBuildingsAndFloors()
            self.loadPOIs()
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        
        mapView?.darkMode = traitCollection.userInterfaceStyle == .dark
    }
    
    // MARK: Custom
    func listBuildingsAndFloors() {
        
        for building in venue!.buildings! {
            
            print("Building name:", building.name!)
            print("Building id:", building.buildingId!)
            
            for floor in building.floors {
                
                print("Floor ordinal:", floor.ordinal!)
                print("Floor id:", floor.floorId!)
            }
        }
    }
    
    func loadPOIs() {
        
        venue?.poiDatabase()?.loadAllPois({ pois in
            
            for poi in pois as! [LLPOI] {
                
                print("Name:", poi.name!)
                print("ID:", poi.poiId!)
                print("Position:", poi.position!)
            }
        })
    }
    
    // MARK: Delegates - LLVenueDatabase
    func venueDatabase(_ venueDatabase: LLVenueDatabase!, venueList: [Any]!) {
        
        for venueInfo in venueList as! [LLVenueInfo] {
            
            let airportCode = venueInfo.venueId.count > 3 ? String(venueInfo.venueId.prefix(3)) : venueInfo.venueId
            print("Venue name:", venueInfo.name!)
            print("Venue id:", venueInfo.venueId!)
            print("Airport code:", airportCode!)
        }
    }
    
    func venueDatabase(_ venueDatabase: LLVenueDatabase!, venueLoadFailed venueId: String!, code errorCode: LLDownloaderError, message: String!) {
        
        // Handle failures here
    }
    
    // MARK: Delegates - LLMapView
    func mapViewDidClickBack(_ mapView: LLMapView!) {
        
        // The user tapped the "Cancel" button while the map was loading. Dismiss the app or take other appropriate action here
    }
    
    func mapViewReady(_ mapView: LLMapView!) {
        
        // The map is ready to be used in calls e.g. zooming, showing poi, etc.
    }
    
    func presentingController(for mapView: LLMapView!, for context: LLMapViewPresentationContext) -> UIViewController! {
        
        // Return a viewcontroller the SDK can use to present alerts
        return self
    }
}

