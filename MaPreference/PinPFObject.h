//
//  PinPFObject.h
//  MaPreference
//
//  Created by Abegael Jackson & Oliver Andrews on 2015-06-05.
//  Copyright (c) 2015 Abegael Jackson & Oliver Andrews. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>

@class PinAnnotation;


@interface PinPFObject : PFObject<PFSubclassing>


@property (nonatomic, strong) NSString *usernameString;
@property (nonatomic, strong) PFGeoPoint *location;
@property (nonatomic, strong) NSString *businessName;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *addressString;
@property (nonatomic, strong) NSMutableArray *reviews;


+ (NSString *)parseClassName;

- (PinAnnotation *) makeAnnotation:(PinPFObject *)pinObject;

-(CLLocation *)convertGeoPointToCLLocation;


@end
