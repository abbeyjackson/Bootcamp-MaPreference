//
//  PinPFObject.m
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-05.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import "PinPFObject.h"
#import <Parse/PFObject+Subclass.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@implementation PinPFObject

@dynamic usernameString;
@dynamic location;
@dynamic businessName;
@dynamic userID;
@dynamic addressString;
@dynamic reviews;


+(void)load {
    
    [self registerSubclass];
    
}

+(NSString *)parseClassName {
    
    return @"Location";
    
}

-(CLLocation *)convertGeoPointToCLLocation {
    
    PFGeoPoint *point = [self valueForKey:@"location"];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:point.latitude longitude:point.longitude];
    
    return location;
    
}

- (MKPointAnnotation *) annotation:(PinPFObject *)pinObject {
    
    MKPointAnnotation *marker = [[MKPointAnnotation alloc] init];
    marker.coordinate = [pinObject convertGeoPointToCLLocation].coordinate;
    
    return marker;
}

@end
