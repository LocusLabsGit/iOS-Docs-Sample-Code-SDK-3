//
//  ViewController.swift
//  ShowFullscreenMapSwift
//
//  Created by Juan Kruger on 2020/05/06.
//  Copyright © 2020 LocusLabs. All rights reserved.
//

import UIKit

// NB - You may need to run "pod update" before running this code

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
    func locationDict(lat: NSNumber!, lon:NSNumber!, floorID:String!) -> [String: Any]  {
    
        let latLng = LLLatLng(lat: lat, lng: lon)
        
        var locationDict = [String: Any]()
        locationDict["latLng"] = latLng
        locationDict["errorRadius"] = NSNumber(value: 1)
        locationDict["floorId"] = floorID
        locationDict["heading"] = NSNumber(value: 34)
        
        return locationDict
    }
    
    func postUserPosition(locationDict: [String: Any]!) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_POSITION_SENSOR_POSITION_CHANGED), object: nil, userInfo: locationDict)
    }
    
    // MARK: Delegates - LLVenueDatabase
    func venueDatabase(_ venueDatabase: LLVenueDatabase!, venueLoadFailed venueId: String!, code errorCode: LLDownloaderError, message: String!) {
        
        // Handle failures here
    }
    
    // MARK: Delegates - LLMapView
    func mapViewDidClickBack(_ mapView: LLMapView!) {
        
        // The user tapped the "Cancel" button while the map was loading. Dismiss the app or take other appropriate action here
    }
    
    func mapViewReady(_ mapView: LLMapView!) {
        
        // Set the navigation source to internal & send timed navigation points
        let algorithm = NSNumber(value: Int8(LLPositioningSensorAlgorithmExternal.rawValue))
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_SET_POSITIONING_SENSOR_ALGORITHM), object: nil, userInfo: ["positioningSensorAlgorithm": algorithm])
        
        var locationDict = Dictionary<String, Any>()
        
        // Position 1 (Initial - DFS Duty Free)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            
            locationDict = self.locationDict(lat: NSNumber(value: 33.941485), lon: NSNumber(value: -118.40195), floorID: "lax-south-departures")
            self.postUserPosition(locationDict: locationDict)
        }
        
        // Position 2 (2 secs later)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
           
            locationDict = self.locationDict(lat: NSNumber(value: 33.941398), lon: NSNumber(value: -118.401916), floorID: "lax-south-departures")
            self.postUserPosition(locationDict: locationDict)
        }
        
        // Position 3 (4 secs later)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
            
            locationDict = self.locationDict(lat: NSNumber(value: 33.941283), lon: NSNumber(value: -118.401863), floorID: "lax-south-departures")
            self.postUserPosition(locationDict: locationDict)
        }
        
        // Position 4 (6 secs later)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6)) {
            
            locationDict = self.locationDict(lat: NSNumber(value: 33.941102), lon: NSNumber(value: -118.401902), floorID: "lax-south-departures")
            self.postUserPosition(locationDict: locationDict)
        }
        
        // Position 5 (8 secs later - Destination - Gate 64B)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(8)) {
            
            locationDict = self.locationDict(lat: NSNumber(value: 33.940908), lon: NSNumber(value: -118.40177), floorID: "lax-south-departures")
            self.postUserPosition(locationDict: locationDict)
        }
    }
    
    func presentingController(for mapView: LLMapView!, for context: LLMapViewPresentationContext) -> UIViewController! {
        
        // Return a viewcontroller the SDK can use to present alerts
        return self
    }
}

