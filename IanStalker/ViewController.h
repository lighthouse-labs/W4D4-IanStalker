//
//  ViewController.h
//  IanStalker
//
//  Created by Ian MacKinnon on 2015-04-02.
//  Copyright (c) 2015 Ian MacKinnon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end

