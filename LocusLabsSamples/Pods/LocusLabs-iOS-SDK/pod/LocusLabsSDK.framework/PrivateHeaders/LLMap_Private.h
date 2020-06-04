//
//  LLMap_Private.h
//  LocusLabsSDK
//
//  Created by Rafal Hotlos on 28/05/2020.
//  Copyright © 2020 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocusLabsSDK/LLMap.h>

@interface LLMap ()

/**
 Animates the map center and radius
 
 @param center new map center
 @param radius new map radius
 */
- (void)setCenter:(LLLatLng *)center radius:(NSNumber *)radius;

/**
 Animates the map center and radius. Positions the map center in the area adjusted by the edgePadding.
 
 @param center new map center
 @param radius new map radius
 @param edgePadding padding to use when centering the map
 */
- (void)setCenter:(LLLatLng *)center radius:(NSNumber *)radius edgePadding:(UIEdgeInsets)edgePadding;

@end
