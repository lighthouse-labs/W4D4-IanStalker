//
//  ViewController.m
//  IanStalker
//
//  Created by Ian MacKinnon on 2015-04-02.
//  Copyright (c) 2015 Ian MacKinnon. All rights reserved.
//

#import "ViewController.h"

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
    
    MKCoordinateRegion startingRegion;
    CLLocationCoordinate2D loc = _locationManager.location.coordinate;
    startingRegion.center = loc;
    startingRegion.span.latitudeDelta = 0.02;
    startingRegion.span.longitudeDelta = 0.02;

    MKPointAnnotation *apartmentMarker=[[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D iansApartmentLocation;
    iansApartmentLocation.latitude = 49.2689754;
    iansApartmentLocation.longitude = -123.153034;
    apartmentMarker.coordinate = iansApartmentLocation;
    apartmentMarker.title = @"Ian's Pad";
    
    MKPointAnnotation *officeMarker=[[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D launchAcademyLocation;
    launchAcademyLocation.latitude = 49.2816252;
    launchAcademyLocation.longitude = -123.1091366;
    officeMarker.coordinate = launchAcademyLocation;
    officeMarker.title = @"Ian's Office (for now)";
    
    [self.mapView addAnnotation:apartmentMarker];
    [self.mapView addAnnotation:officeMarker];
    
    [self.mapView setRegion:startingRegion];
    
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
