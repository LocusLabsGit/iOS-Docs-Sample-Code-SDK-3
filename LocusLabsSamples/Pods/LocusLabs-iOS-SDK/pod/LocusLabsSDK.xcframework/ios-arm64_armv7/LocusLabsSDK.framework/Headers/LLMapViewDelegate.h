//
//  LLMapViewDelegate.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 7/22/14.
//  Copyright © 2014-2021 LocusLabs, Inc. All rights reserved.
//  Copyright © 2021 Acuity Brands, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLMapView;
@class LLMarker;
@class LLLatLng;
@class LLPosition;
@class LLPoint;
@class LLPOI;
@class LLVenue;

typedef enum _LLMapViewMode
{
    LLMapViewModeNormal = 1,
    LLMapViewModeNavigation
} LLMapViewMode;

typedef NS_ENUM(NSInteger, LLMapViewPresentationContext)
{
	LLMapViewPresentationContextAlert,
	LLMapViewPresentationContextCheckIn,
	LLMapViewPresentationContextVouchers,
	LLMapViewPresentationContextPOI
};

@protocol LLMapViewDelegate <NSObject>

@optional

- (void)mapViewReady:(LLMapView *)mapView;

/**
 * Is called by the LLMapView if it was reloaded with the new version of venue. This may happen if the map view initially opened with a local (on device) version of the venue and
 * then the latest version was downloaded and user took action to reload the map view.
 *
 * @param mapView the mapView that generated the event
 * @param venue the new version of venue that was loaded
 */
- (void)mapView:(LLMapView *)mapView venueUpdated:(LLVenue *)venue;

/**
 *  Is called by the LLMapView whenever a marker on the map is tapped.
 *
 *  @param mapView the mapView that generated the event
 *  @param marker  the marker that was tapped
 *
 *  @return return TRUE if the event has been handled, FALSE if mapView should continue with it's default processing.
 */
- (BOOL)mapView:(LLMapView *)mapView didTapMarker:(LLMarker *)marker;

/**
 *  Called whenever a point on the map not containing a marker is tapped.
 *
 *  @param mapView the mapView that generated the event
 *  @param latLng  the point where the tap event occurred
 */
- (void)mapView:(LLMapView *)mapView didTapAtLatLng:(LLLatLng *)latLng;

/**
 *  Called whenever a point on the map not containing a marker is tapped.
 *
 *  @param mapView the mapView that generated the event
 *  @param position the position where the tap event occurred
 */
- (void)mapView:(LLMapView *)mapView didTapAtPosition:(LLPosition *)position;

/**
 *  Called whenever a POI on the map has been tapped.
 *
 *  @param mapView the mapView that generated the event
 *  @param poiId   the id of the POI that was tapped
 */
- (BOOL)mapView:(LLMapView *)mapView didTapPOI:(NSString *)poiId;

/**
 *	Called just before a POI is about to display to allow additional views/controls to be displayed beside the Navigate button.
 *	@note Returning nil or an empty array are both valid ways of ignoring this method for some POIs and not others.
 *
 *	@param mapView	the mapView that generated the event
 *	@param poiId	the id of the POI that will be displayed
 *
 *	@returns An array of LLIconButton objects that define buttons to be displayed in addtiotion to the Navigate button. (Alternatively this method also accepts UIView objects, but the LLIconButton is prefered as it can be styled and layed out properly).
 */
- (NSArray *)mapView:(LLMapView *)mapView additionalViewsForPOI:(NSString *)poiId;

- (void)mapViewDidClickBack:(LLMapView *)mapView;
- (void)mapView:(LLMapView *)mapView floorChanged:(NSString *)floorId;
- (void)mapView:(LLMapView *)mapView modeChanged:(LLMapViewMode)mode;

/**
 * Provide an alternate marker icon URL for the LLMapView to use for specific POIs.
 *
 * @param mapView the mapView that generated the event
 * @param poi   the POI
 */
- (NSString *)mapView:(LLMapView *)mapView markerIconUrlForPOI:(LLPOI *)poi;

/**
 * Provide an alternate anchor point for the LLMapView to use for specific POIs.  If an alternate icon url is also provided,
 * then the anchor will default to the bottom center of the icon.
 * @param mapView the mapView that generated the event
 * @param poiId   the id of the POI
 *
 * @deprecated This method is deprecated and not used in SDK 3.0 *
 */
- (LLPoint *)mapView:(LLMapView *)mapView markerAnchorForPOI:(NSString *)poiId __attribute__((deprecated("This method is not used in SDK >= 3.0")));;

- (BOOL)mapView:(LLMapView *)mapView isSponsoredSearchResult:(NSString *)poiId;

/**
 * Called whenever the map view needs to present a view controller modally.
 * In most cases, the view controller returned should be the same that owns the MapView.
 * @param mapView the mapView that generated the event
 * @param context a flag indicating what context/event is asking for the presentation controller, for cases where a different controller might be needed
 * @returns A view controller upon which a presentation will be made.
 */
- (UIViewController *)presentingControllerForMapView:(LLMapView *)mapView forContext:(LLMapViewPresentationContext)context;

/**
 * This method might be used to provide alternate recommended places configuration file.
 *
 * By default path = [<LocusLabsSDKBundle> pathForResource:@"DefaultPlaces" ofType:@"json"];
 *
 * @param mapView the mapView that generated the event
 * @returns path to JSON file with places configuration
 */
- (NSString *)mapViewPathForPlacesConfiguration:(LLMapView *)mapView;

/**
 * @brief This method is called when the map is about to display any featured places.
 * The <code>places</code> array may be empty or already have <code>LLPlace</code> objects in it. Either way,
 * this method should return the array with any desired modifications, such as additional items
 * or rearranged order.
 * @param mapView the mapView that generated the event
 * @param places the array of <code>LLPlace</code> objects
 * @returns a modified version of the <code>places</code> array, a new array of <code>LLPlace</code> objects, or an empty array
 */
- (NSArray *)mapView:(LLMapView *)mapView willPresentPlaces:(NSArray *)places;

/**
 * @brief This method is called when the search panel is about to display suggestions.
 * The suggestions array may be empty or already have strings in it.
 * These strings will simply act as search terms when selected. Either way,
 * this method should return the array with any desired modifications,
 * such as additional items, removed items, or rearranged order.
 * @param mapView the mapView that generated the event
 * @param suggestions the array of strings
 * @returns a modified version of the suggestions array, a new array of strings, or an empty array
 */
- (NSArray<NSString*> *)mapView:(LLMapView *)mapView willPresentSearchSuggestions:(NSArray<NSString*> *)suggestions;

@end
