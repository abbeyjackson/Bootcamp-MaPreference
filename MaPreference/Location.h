//
//  Location.h
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-04.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@class PinLocation;

@interface Location : NSObject <MKAnnotation>


@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *review;


@property (nonatomic, strong, readonly) PinLocation *object;
@property (nonatomic, strong, readonly) PFUser *user;
@property (nonatomic, assign) BOOL animatesDrop;
@property (nonatomic, assign, readonly) MKPinAnnotationColor pinColor;

@end
