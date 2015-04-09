//
//  IanStalkerTests.m
//  IanStalkerTests
//
//  Created by Ian MacKinnon on 2015-04-02.
//  Copyright (c) 2015 Ian MacKinnon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IanLocations.h"
#import "ViewController.h"

#import <Nocilla.h>
#import <AFNetworking.h>

@interface IanStalkerTests : XCTestCase

@end

@implementation IanStalkerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [IanLocations reset];
    [[LSNocilla sharedInstance] start];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testOnePlueOneisTwo {
    // This is an example of a functional test case.
    XCTAssert(1+1 == 2, @"Pass");
}

-(void)testCenterLocationFirstInArray{
    
    [IanLocations addLocation:@"Ian's Place" withLat:49.2682029 andLng:-123.153424];
    [IanLocations addLocation:@"Subeez" withLat:49.2783442 andLng:-123.1198427];
    
    CLLocationCoordinate2D center =[IanLocations centerLocation];
    XCTAssertEqualWithAccuracy(49.2682029, center.latitude, 0.001, @"test");
}

-(void)testAdditionalLocationsAreAdded{
    
    [IanLocations addLocation:@"Ian's Place" withLat:49.2682029 andLng:-123.153424];
    
    NSInteger count =[IanLocations iansLocations].count;
    XCTAssert( count == 1, @"Pass");
    
    [IanLocations addLocation:@"Subeez" withLat:49.2783442 andLng:-123.1198427];
    
    XCTAssert([IanLocations iansLocations].count == 2, @"Pass");
}

-(void) testView{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"viewController"];
    [vc performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    
    XCTAssertNotNil(vc.mapView, @"Map View Rendered");
}

- (void)testGetListOfIansFavouritePark {

    stubRequest(@"GET", @"http://www.amierotherham.com/weekendplayfieldstatus.json").
    andReturn(201).
    withHeaders(@{@"Content-Type": @"application/json"}).
    withBody(@"[{\"park_name\":\"Adanac Park\",\"closure_notes\":\"Summer field\",\"site_area\":\"NW\",\"park_id\":65,\"last_updated\":\"Mar 27 2015\"}]");

    XCTestExpectation *expectation =
    [self expectationWithDescription:@"High Expectations"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://www.amierotherham.com/weekendplayfieldstatus.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *jsonArray = (NSArray *) responseObject;
        NSLog(@"JSON: %@", jsonArray);
        
        XCTAssertNotNil([jsonArray firstObject], @"Pass");
        [expectation fulfill];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
    
    [[LSNocilla sharedInstance] stop];
    [[LSNocilla sharedInstance] clearStubs];
    
}




@end
