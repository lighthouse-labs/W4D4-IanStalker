//
//  IanLocations.m
//  
//
//  Created by Ian MacKinnon on 2015-04-09.
//
//

#import "IanLocations.h"

@implementation IanLocations


+(id)sharedArray{
    static NSMutableArray *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[NSMutableArray alloc] init];;
    });
    
    return __instance;
}


+(void) addLocation:(NSString*) title withLat:(float)lat andLng:(float)lng{
    
    MKPointAnnotation *marker=[[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D iansApartmentLocation;
    iansApartmentLocation.latitude = lat;
    iansApartmentLocation.longitude = lng;
    marker.coordinate = iansApartmentLocation;
    marker.title = title;
    
    [[IanLocations sharedArray] addObject: marker];
    
}

+(CLLocationCoordinate2D)centerLocation{
    return (CLLocationCoordinate2D)[[[IanLocations sharedArray] firstObject]coordinate];
}

+(NSArray*) iansLocations{
    return [IanLocations sharedArray];
}

@end

