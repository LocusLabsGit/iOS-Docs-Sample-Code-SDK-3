//
//  ViewController.swift
//  LocusLabsSamplesSwift
//
//  Copyright © 2020 LocusLabs. All rights reserved.
//
// *********************************************************************************************
// NB - You may need to run "pod update" before running this code
// *********************************************************************************************

import UIKit

class ViewController: UITableViewController {

    var samples: Array<String>!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Demo Samples"
        
        samples = ["Fullscreen Map", "Embedded Map", "Bundled Map", "Custom Actions", "Directions Requested", "Directions - Steps & ETA",
        "Directions UI", "External Location Services", "GRAB Integration" ,"Map Basics", "Markers", "POI Buttons", "POI Show",
        "Recommended Searches", "Search Auto Display", "Search Categories", "Search General", "Search Multiterm", "Search Proximity",
        "UI Customization", "User Location Simulated", "User Location Tracking", "Venue Data"]
    }

    override func viewWillAppear(_ animated: Bool) {
            
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: Delegates - TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return samples.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "reuseIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        
        if cell == nil {
            
            cell = UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        }
        
        let sample = samples[indexPath.row]
        cell?.textLabel?.text = sample
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sample = samples[indexPath.row]
        var vcToShow: UIViewController?
        
        if sample == "Fullscreen Map" {vcToShow = ShowFullscreenMap() as UIViewController}
        else if sample == "Embedded Map" {vcToShow = ShowEmbeddedMap() as UIViewController}
        else if sample == "Bundled Map" {vcToShow = BundledMap() as UIViewController}
        else if sample == "Custom Actions" {vcToShow = CustomActions() as UIViewController}
        else if sample == "Directions Requested" {vcToShow = DirectionsRequested() as UIViewController}
        else if sample == "Directions - Steps & ETA" {vcToShow = DirectionsStepsETA() as UIViewController}
        else if sample == "Directions UI" {vcToShow = DirectionsUI() as UIViewController}
        else if sample == "External Location Services" {vcToShow = ExternalLocationServices() as UIViewController}
        else if sample == "GRAB Integration" {vcToShow = IntegrationGrab() as UIViewController}
        else if sample == "Map Basics" {vcToShow = MapBasics() as UIViewController}
        else if sample == "Markers" {vcToShow = Markers() as UIViewController}
        else if sample == "POI Buttons" {vcToShow = POIButtons() as UIViewController}
        else if sample == "POI Show" {vcToShow = POIShow() as UIViewController}
        else if sample == "Recommended Searches" {vcToShow = RecommendedSearches() as UIViewController}
        else if sample == "Search Auto Display" {vcToShow = SearchAutoDisplay() as UIViewController}
        else if sample == "Search Categories" {vcToShow = SearchCategories() as UIViewController}
        else if sample == "Search General" {vcToShow = SearchGeneral() as UIViewController}
        else if sample == "Search Multiterm" {vcToShow = SearchMultiTerm() as UIViewController}
        else if sample == "Search Proximity" {vcToShow = SearchProximity() as UIViewController}
        else if sample == "UI Customization" {vcToShow = UICustomization() as UIViewController}
        else if sample == "User Location Simulated" {vcToShow = UserLocationSimulated() as UIViewController}
        else if sample == "User Location Tracking" {vcToShow = UserPositionTracking() as UIViewController}
        else if sample == "Venue Data" {vcToShow = VenueData() as UIViewController}
        
        guard vcToShow != nil else {
            return
        }
        
        vcToShow?.modalPresentationStyle  = .fullScreen
        navigationController?.pushViewController(vcToShow!, animated: true)
    }
}

