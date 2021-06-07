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

@end
