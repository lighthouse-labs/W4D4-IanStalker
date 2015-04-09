//
//  IanLocations.h
//  
//
//  Created by Ian MacKinnon on 2015-04-09.
//
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface IanLocations : NSObject

+(void) addLocation:(NSString*) title withLat:(float)lat andLng:(float)lng;

+(NSArray*) iansLocations;

+(CLLocationCoordinate2D)centerLocation;

@end
