//
//  ViewController.m
//  IanStalker
//
//  Created by Ian MacKinnon on 2015-04-02.
//  Copyright (c) 2015 Ian MacKinnon. All rights reserved.
//

#import "ViewController.h"
#import "IanLocations.h"

@interface ViewController (){
    CLLocationManager *_locationManager;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _mapView.delegate = self;
    _locationManager.delegate = self;
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];
    
    
    self.mapView.showsUserLocation =true;
    
    [IanLocations addLocation:@"Ian's Place" withLat:49.2682029 andLng:-123.153424];
    [IanLocations addLocation:@"Subeez" withLat:49.2783442 andLng:-123.1198427];
    [IanLocations addLocation:@"Launch Academy" withLat:49.2808961 andLng:-123.1096094];
    [IanLocations addLocation:@"Urban Beach" withLat:49.2706879 andLng:-123.0877297];
    
    MKCoordinateRegion startingRegion;
    CLLocationCoordinate2D loc = [IanLocations centerLocation];
    startingRegion.center = loc;
    startingRegion.span.latitudeDelta = 0.02;
    startingRegion.span.longitudeDelta = 0.02;
    
    [self.mapView setRegion:startingRegion];
    
    for (MKPointAnnotation* annotation in [IanLocations iansLocations] ){
        [self.mapView addAnnotation:annotation];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse){
        NSLog(@"We got permission yo");
    } else if (status == kCLAuthorizationStatusDenied ){
        NSLog(@"the user is not a fan of being stalked");
    }
    
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)_annotation{
    
    
    if (_annotation == self.mapView.userLocation){
        return nil; //default to blue dot
    }
    
    static NSString* annotationIdentifier = @"ianAnnotation";
    
    MKPinAnnotationView* pinView = (MKPinAnnotationView *)
    [self.mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    
    if (!pinView) {
        // if an existing pin view was not available, create one
        pinView = [[MKPinAnnotationView alloc]
                   initWithAnnotation:_annotation reuseIdentifier:annotationIdentifier];
    }
    
    pinView.canShowCallout = YES;
    pinView.pinColor = MKPinAnnotationColorGreen;
    //pinView.calloutOffset = CGPointMake(-7, 0);
    
    return pinView;
}

-(void)locationManager:(CLLocationManager *)manager
didUpdateLocations:(NSArray *)locations{
    NSLog(@"New Location Update %@", [locations firstObject]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
