//
//  LLMapView.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/12/14.
//  Copyright © 2014-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <LocusLabsSDK/LLMapTips.h>
#import <LocusLabsSDK/LLMapViewDelegate.h>
#import <LocusLabsSDK/LLPosition.h>

@class LLVenue;
@class LLFlight;
@class LLMap;
@class LLPOI;
@class LLPositionManager;
@class LLTheme;

/**
 *  UIView for displaying LocusLabs floor maps.
 */
@interface LLMapView : UIView

/**
 *  The map being rendered.
 */
@property (strong, nonatomic, readonly) LLMap *map;

// TODO [api] document as it's probably used in 1.6
@property (nonatomic, getter=shouldShowMyPositionNav) BOOL showMyPositionNav;

// Hide me!
@property (strong,nonatomic) LLPositionManager *positionManager;

/**
 *  A delegate object to receive map events.
 */
@property (weak,nonatomic) id<LLMapViewDelegate> delegate;

/**
 *  Set the visibile radius around the center point.
 */
@property (nonatomic, strong) NSNumber *mapRadius;

/**
 *  Set the center point of the map view.
 */
@property (nonatomic, strong) LLLatLng *mapCenter;

/**
 * Set the user's current departing flight
 */
@property (strong,nonatomic) LLFlight *departingFlight;

/**
 * Display information about specific flights
 */
@property (strong,nonatomic) NSArray *flights;

/**
 * Should the LocusLabs UI include 20 extra pixels at the top to appear behind the status bar? Default: NO
 */
@property (nonatomic) BOOL shouldAllowSpaceForStatusBar;

/**
 * A disclaimer to presented to the user before showing them the result of the navigation.
 * To show the alert with a disclaimer LLMapViewDelegate must provide a presentation controller for LLMapViewPresentationContextAlert
 */
@property (strong,nonatomic) NSString *navigationDisclaimer;

// TODO [api] document as it's probably used in 1.6
@property (nonatomic) BOOL showNavButton;

/**
 * Allows the back button on the Search Header to be removed.
 * This makes the search bar itself bigger.
 * Default value: YES
 */
@property (nonatomic) BOOL showBackButton;

/**
 * Allow to show/hide the overlay covering the top safe area of the map view.
 * Default value: YES
 */
@property (nonatomic) BOOL showTopSafeAreaOverlay;

/**
 * The venue associated with this map.
 */
@property (readonly,nonatomic) LLVenue *venue;

/**
 *  A LLMapView is created to render a map within the given frame.
 *
 *  @param frame the view frame
 *
 *  @return self
 */
- (id)initWithFrame:(CGRect)frame;

/**
 * Zoom to and display the header popup view for the given POI.  The
 * map will switch levels if necessary.
 * This function does nothing if a bad or non-existent POI is given.
 *
 * @param poiId The id of the POI to show.
 */
- (void)showPoiByPoiId:(NSString *)poiId;

/**
 * Zoom to and display the header popup view for the given POI.  The
 * map will switch levels if necessary.
  *
 * @param poi The POI object to show.
 */
- (void)showPoi:(LLPOI *)poi;


// TODO [api] document as it's probably used in 1.6
- (void)didTapMarker:(LLMarker *)marker;

/**
 * The LocusLabs SDK’s track an internal “session id” (a cryptographically correct UUID) to track user activity while using our maps.
 * A session is created as part of loading a map. When a user does something “interesting” on a map (move, view a POI, etc)
 * the app sends data to our analytics database associated with the session id.
 *
 * This property is available once the map view is ready.
 *
 * *Warning* this
 *
 * @return session id
 */
@property (nonatomic, readonly) NSString* sessionId __deprecated_msg("this will always return nil");

// TODO [api] document as it's probably used in 1.6
- (void)levelSelected:(NSString*)levelName;

// TODO [api] document as it's probably used in 1.6
- (void)addUserPOI:(LLPOI*)poi userLabel:(NSString*)label;
// TODO [api] document as it's probably used in 1.6
- (void)removeUserPOI:(LLPOI*)poi;
// TODO [api] document as it's probably used in 1.6
- (void)navigateFromStart:(LLPosition*)start end:(LLPosition*)end;

/**
 * Programmatically open the navigation dialog passing in (optional) start and end positions
 */
-(void)openNavigationViewWithStart:(LLPosition*)navStart andEnd:(LLPosition*)navEnd;

/**
 * Programmatically open the navigation dialog passing in (optional) start, end, and current positions
 */
-(void)openNavigationViewWithStart:(LLPosition*)navStart andEnd:(LLPosition*)navEnd andCurrent:(LLPosition*)current;

/**
 * Programmatically cancel the user initiated navigation.
 */
- (void)cancelUserNavigation;

/**
 * Programmatically cancel user initiated search.
 */
- (void)cancelUserSearch;

/**
 * If set to YES, whenever the user is first located the follow me mode will be enabled and the map will be centered on the user position.
 * If set to NO, there will be no jump to user position when it's first found, but user will be still able to enable follow me mode manually.
 *
 * Default is YES.
 */
@property (nonatomic) BOOL startInFollowMeMode;

/**
 * Toggles the use of positioning to display the user's current position on the map.  Default is YES.
 */
@property (nonatomic) BOOL positioningEnabled;
@property (nonatomic) BOOL shouldShowClosestBeacon;

/**
 * Hide/show the bottom bar.  Default is NO.
 */
@property (nonatomic) BOOL bottomBarHidden;

/**
 * Hide/show the map controls.  Default is NO.
 */
@property (nonatomic) BOOL hideMapControls;

/**
 * Hide/show the directions summary controls.  Default is NO.
 */
@property (nonatomic) BOOL hideDirectionsSummaryControls;

/**
 * Hide/show the recommended places buttons.  Default is NO.
 */
@property (nonatomic) BOOL recommendedPlacesHidden;

/**
 * Loading map state.
 */
@property (nonatomic, readonly, getter=isLoadingMap) BOOL loadingMap;

/**
 * Loading directions state.
 */
@property (nonatomic, readonly, getter=isLoadingDirections) BOOL loadingDirections;

/**
 * Directions would be loaded. If set to yes the map will change it's status to loadingDirections=YES, immediately
 * after loadingMap has finished and was switched to NO. By Default it's NO.
 */
@property (nonatomic) BOOL willInitializeDirections;

/**
 * This property controls whether structure labels (like building, terminal labels) are enabled or not.
 * If set to <code>YES</code> the structure labels will be enabled and shown if the map view is zoomed out.
 * If set to <code>NO</code> the structure labels will be hidden, no matter the zoom level.
 *
 * By default it's set to <code>YES</code>
 */
@property (nonatomic) BOOL structureLabelsEnabled;

/**
 * This property controls whether the compass is shown when the map is not facing North.
 *
 * By default it's set to <code>YES</code>.
 */
@property (nonatomic) BOOL compassEnabled;

@property (retain,nonatomic) UINavigationController *mapTipsNavigationController;
@property (nonatomic) LLMapTipsPopupMethod mapTipsPopupMethod;

// TODO [raho] update docs, so the custom theme can be set anytime
/**
 * Get or set the theme used by this LLMapView.
 * Please note that setting custom theme is only reflected in the UI if set before the <code>mapViewReady:</code>
 * delegate method is called.
 */
@property (strong,nonatomic) LLTheme *theme;

/**
 * Get or set the darkMode for LLMapView.
 * If set to @c YES the map view will use <code>[LLTheme darkTheme]</code> and switch the map to display in dark colors.
 * If you want to provide a custom dark theme while switching to dark mode, use @c -setDarkMode:theme:
 *
 * By default it's set to @c NO.
 */
@property (nonatomic) BOOL darkMode;

/**
 * Sets the darkMode with custom theme.
 * @param darkMode see darkMode
 * @param theme see theme
 */
- (void)setDarkMode:(BOOL)darkMode theme:(LLTheme *)theme;

/**
 * Triggers the reload of places from the venue data, which in turn causes the LLMapViewDelegate willPresentPlaces method to be called again
 */
- (void)refreshPlaces;

/**
 * When highlighting POIs the map is grayed out using this parameter to control the greyscale intensity to make it darker or lighter.
 * It can take any value from [0, 1], where 0 makes the background black.
 *
 * **Deprecated**: this property is not used and has no effect starting with SDK 3.0
 */
@property (nonatomic, strong) NSNumber *desaturationGreyscale DEPRECATED_ATTRIBUTE;


/**
 * This property controls whether the queue lane selection UI is shown when routing through a security checkpoint or other type of a queue.
 * If set to <code>NO</code> the current user preferences for queue types/subtypes are used (see LLUserPreferences).
 * If set to <code>YES</code> the selection UI will be shown and user preferences will be updated based on user choices.
 *
 * By default it's set to <code>YES</code>.
 */
@property (nonatomic) BOOL showQueueSelectionUI;

@property (nonatomic) BOOL showSecurityTypeSelectionUI __deprecated_msg("use showQueueSelectionUI instead");

/**
 * Programmatically perform the function that the UI uses when you hit 'enter' to search in the search screen.
 * As a result all found POIs are highlighted and listed in the bottom search results list, and the searchTerm in displayed in the search bar.
 */
- (void)smartSearch:(NSString *)searchTerm;

@end
