//
//  LLConstants.h
//  LocusLabsSDK
//
//  Created by Juan Kruger on 02/08/2023.
//  Copyright © 2023 Acuity Brands. All rights reserved.
//

#import <Foundation/Foundation.h>

// *********************************************************************************************************************
// OUTBOUND NOTIFICATIONS
//
// These notifications are sent FROM LLPositionManager to indicate changes reported by locuslabs.maps.PositionManager
// In these notifications, the object sent with the notification is the data
// *********************************************************************************************************************

/**
 * NOTIFICATION_POSITION_CHANGED
 *
 * The PositionManager has calculated a new position.
 *
 *  object:     an LLPosition indicating the new position
 *  userInfo:   none
 */
#define NOTIFICATION_POSITION_CHANGED                     @"Position Changed"

/**
 * NOTIFICATION_POSITION_SENSOR_STATE_CHANGED
 *
 * Deprecated and not used anymore.
 */
#define NOTIFICATION_POSITION_SENSOR_STATE_CHANGED        @"Position Sensor State Changed"
#define NOTIFICATION_CLOSEST_BEACON_CHANGED               @"Closest beacon changed"

// *********************************************************************************************************************
// INBOUND NOTIFICATIONS
//
// These notifications are sent TO LLPositionManager to indicate changes to be used by locuslabs.maps.PositionManager
// In these notifications, data is sent in the notification's userInfo dictionary
// *********************************************************************************************************************

/**
 * NOTIFICATION_POSITION_SENSOR_POSITION_CHANGED
 *
 * A third-party positioning system (e.g. IndoorAtlas) indicates a new (non-beacon) position to be sent to the
 * PositionManager as input towards calculating the current position.
 *
 *  object:     not used
 *  userInfo:   "latLng"        LLLatLng indicating the proposed new position
 *              "errorRadius"   NSNumber indicating the accuracy of the new position (represented by a circle in meters)
 *              "floorId"       NSString with the floorId of the relevant floor
 */
#define NOTIFICATION_POSITION_SENSOR_POSITION_CHANGED     @"Position Sensor Position Changed"

/**
 * NOTIFICATION_POSITION_HEADING_CHANGED
 *
 * A third-party positioning system (e.g. IndoorAtlas) indicates a new heading to be sent to the
 * PositionManager.
 *
 *  object:     not used
 *  userInfo:   "heading"        Value between 0 - 360. 0 = North, 90 = East, 180 = South, 270 = West
 */
#define NOTIFICATION_POSITION_HEADING_CHANGED     @"Position Sensor Heading Changed"

/**
 * NOTIFICATION_POSITION_SENSOR_SERVICE_INTERRUPTION
 *
 * Deprecated and not used anymore.
 */
#define NOTIFICATION_POSITION_SENSOR_SERVICE_INTERRUPTION @"Position Sensor Service Interruption"

/**
 * NOTIFICATION_POSITION_CLEAR
 *
 * Clears the position.
 *
 *  object:     not used
 */
#define NOTIFICATION_POSITION_CLEAR @"Clear Position"

/**
 * NOTIFICATION_SHOULD_USE_POSITIONING_SENSORS
 *
 * A command from the calling application to use/not use the third-party positioning system (e.g. IndoorAtlas)
 *
 *  object:     not used
 *  userInfo:   "positioningSensorAlgorithm" LLPositioningSensorAlgorithm indicating which algorithm to use
 *              "positionManager"            LLPositionManager - change for given instance only or for all if not provided
 */
#define NOTIFICATION_SET_POSITIONING_SENSOR_ALGORITHM @"set positioning sensor algorithm"

/**
 * NOTIFICATION_CHANGE_POSITIONING_PARAMETERS
 *
 * A command from the calling application to modify parameters of the PositionManager algorithm. (The HKG demo
 * app uses this call to modify the parameters based on sliders on the front page of the app.) See PositionManager.js
 * for information about the individual parameters
 *
 *  object:     not used
 *  userInfo:   "beaconReadingLifespan" NSNumber (long) indicating the new beaconReadingLifespan to use
 *              "bonusForBeingNearest"  NSNumber (long) indicating the new bonusForBeingNearest to use
 *              "minimumReadingCount"   NSNumber (long) indicating the new minimumReadingCount to use
 */
#define NOTIFICATION_CHANGE_POSITIONING_PARAMETERS        @"Change Positioning Parameters"

/**
* NOTIFICATION_DID_ENTER_BEACON_REGION
*
* The CLLocationManager reports that the user has entered a new beacon region
*
* object:       the CLBeaconRegion entered
* userInfo:     not used
*/
#define NOTIFICATION_DID_ENTER_BEACON_REGION  (@"NOTIFICATION_DID_ENTER_BEACON_REGION")

/**
* NOTIFICATION_DID_ENTER_BEACON_REGION
*
* The CLLocationManager reports that the user has exited a beacon region
*
* object:       the CLBeaconRegion entered
* userInfo:     not used
*/
#define NOTIFICATION_DID_EXIT_BEACON_REGION   (@"NOTIFICATION_DID_EXIT_BEACON_REGION")

/*
* Should we be using positioning sensors for location?
*
* (A PositionSensor sends periodic information about position that includes a LatLng and errorRadius)
*/
typedef enum LLPositioningSensorAlgorithm {
    LLPositioningSensorAlgorithmInternal = 0, // default: use our own positioning
    LLPositioningSensorAlgorithmHybrid __attribute__((deprecated)), // not supported anymore
    LLPositioningSensorAlgorithmExternal      // use a third party's positioning instead of our own
} LLPositioningSensorAlgorithm;


@interface LLConstants : NSObject

@end

