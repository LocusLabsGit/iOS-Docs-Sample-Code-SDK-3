//

//  Copyright © 2020 LocusLabs. All rights reserved.
//

import UIKit

// NB - You may need to run "pod update" before running this code

class ExternalLocationServices: UIViewController, LLVenueDatabaseDelegate, LLMapViewDelegate {

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
            
            // Set the navigation source to external
            let algorithm = NSNumber(value: Int8(LLPositioningSensorAlgorithmExternal.rawValue))
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_SET_POSITIONING_SENSOR_ALGORITHM), object: nil, userInfo: ["positioningSensorAlgorithm": algorithm])
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        
        mapView?.darkMode = traitCollection.userInterfaceStyle == .dark
    }
    
    // MARK: Custom
    // This is a pseudo method to demonstrate how data may be received from an external provider and how it can be passed to our SDK
    func didReceiveExternalLocation(_ dict: [String: Any]) {
        
        if let externalFloorId = dict["FloorId"] as? String {
        
            if let locusLabsFloorId = locusLabsFloorIDFor(externalFloorId: externalFloorId) {
                
                let theLocationDict = locationDict(lat: dict["Lat"] as? NSNumber, lon: dict["Lon"] as? NSNumber, floorId: locusLabsFloorId, heading: nil)
                postUserPosition(locationDict: theLocationDict)
            }
        }
    }
    
    func hideBlueDot() {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_POSITION_CLEAR), object: nil, userInfo: nil)
    }
    
    func locationDict(lat: NSNumber!, lon:NSNumber!, floorId:String!, heading:NSNumber?) -> [String: Any]  {
    
        let latLng = LLLatLng(lat: lat, lng: lon)
        
        var locationDict = [String: Any]()
        locationDict["latLng"] = latLng
        locationDict["errorRadius"] = NSNumber(value: 1)
        locationDict["floorId"] = floorId
        if heading != nil {locationDict["heading"] = heading} // Optional
        
        return locationDict
    }
    
    func locusLabsFloorIDFor(externalFloorId: String!) -> String? {
        
        // If you are not able to compile this mapping table yourself, please send us a list (help@locuslabs.com) of
        // the building names and associated floor ids as provided by your external mapping provider and we will compile the mapping table
        // To obtain a list of all LocusLabs buildings and associated floors for this venue, uncomment the line [self.venue listBuildings] in viewDidLoad
        var locusLabsFloorId: String?
        
        if externalFloorId == "T48L3" {locusLabsFloorId = "lax-south-departures"}
        else if externalFloorId == "???" {locusLabsFloorId = "???"}
        else if externalFloorId == "???" {locusLabsFloorId = "???"}
        
        return locusLabsFloorId
    }
    
    func mockExternalLocationData() {
        
        // Position 1 (Initial - DFS Duty Free)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            
            let locationDict = ["FloorId":"T48L3", "Lat":NSNumber(value:33.941485), "Lon":NSNumber(value:-118.40195)] as [String : Any]
            self.didReceiveExternalLocation(locationDict)
        }
        
        // Position 2 (2 secs later)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            
            let locationDict = ["FloorId":"T48L3", "Lat":NSNumber(value:33.941398), "Lon":NSNumber(value:-118.401916)] as [String : Any]
            self.didReceiveExternalLocation(locationDict)
        }
        
        // Position 3 (4 secs later)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            
            let locationDict = ["FloorId":"T48L3", "Lat":NSNumber(value:33.941283), "Lon":NSNumber(value:-118.401863)] as [String : Any]
            self.didReceiveExternalLocation(locationDict)
        }
        
        // Position 4 (6 secs later)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(7)) {
            
            let locationDict = ["FloorId":"T48L3", "Lat":NSNumber(value:33.941102), "Lon":NSNumber(value:-118.401902)] as [String : Any]
            self.didReceiveExternalLocation(locationDict)
        }
        
        // Position 5 (8 secs later - Destination - Gate 64B)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(9)) {
            
            let locationDict = ["FloorId":"T48L3", "Lat":NSNumber(value:33.940908), "Lon":NSNumber(value:-118.40177)] as [String : Any]
            self.didReceiveExternalLocation(locationDict)
        }
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
        navigationController?.popViewController(animated: true)
    }
    
    func mapViewReady(_ mapView: LLMapView!) {
        
        // The map is ready to be used in calls e.g. zooming, showing poi, etc.
        mockExternalLocationData()
    }
    
    func presentingController(for mapView: LLMapView!, for context: LLMapViewPresentationContext) -> UIViewController! {
        
        // Return a viewcontroller the SDK can use to present alerts
        return self
    }
}

