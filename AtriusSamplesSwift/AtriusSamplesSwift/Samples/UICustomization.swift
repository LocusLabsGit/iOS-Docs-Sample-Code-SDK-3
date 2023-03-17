//

//  Copyright © 2021 Atrius, part of Acuity Brands. All rights reserved.
//

import UIKit

// NB - You may need to run "pod update" before running this code

class UICustomization: UIViewController, LLVenueDatabaseDelegate, LLMapViewDelegate {

    // Vars
    var venueDatabase:      LLVenueDatabase!
    var venue:              LLVenue?
    var mapView:            LLMapView?
    
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
        
        // UI Theming
        //updateUIFonts()
        updateUIColors();
        
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
    func updateUIColors() {
        
        let themeBuilder = LLThemeBuilder(theme: LLTheme.default())

        // Change icon colors in the search bar
        themeBuilder.setProperty("colors.globalSecondaryText", value: UIColor.orange)
      
        // Change the action bar item text (coffee, bars, etc.)
        themeBuilder.setProperty("colors.globalPrimaryText", value: UIColor.gray);
      
        mapView?.theme = themeBuilder.theme
        
        // If you have implemented dark mode, you need to set the theme as follows for that mode
        // mapView?.setDarkMode(true, theme: darkThemeBuilder.theme)
    }
    
    func updateUIFonts() {
        
        let customFont = UIFont(name: "American Typewriter", size: 16.0)
        
        let themeBuilder = LLThemeBuilder(theme: LLTheme.default())
  
        // This updates the search bar placeholder text and other places where the original font was used
        themeBuilder.setProperty("fonts.H2_Regular", value: customFont!)
        
        // This updates the action bar text and other places where the original font was used
        themeBuilder.setProperty("fonts.H3_Semibold", value:customFont!);
        
        mapView?.theme = themeBuilder.theme
        
        // If you have implemented dark mode, you need to set the theme as follows for that mode
        // mapView?.setDarkMode(true, theme: darkThemeBuilder.theme)
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
    }
    
    func presentingController(for mapView: LLMapView!, for context: LLMapViewPresentationContext) -> UIViewController! {
        
        // Return a viewcontroller the SDK can use to present alerts
        return self
    }
}

