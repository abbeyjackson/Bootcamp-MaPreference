//
//  PinPFObject.h
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-05.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>

@interface PinPFObject : PFObject<PFSubclassing>

@property (nonatomic, strong) PFUser *user;
@property (nonatomic, strong) PFGeoPoint *location;
@property (nonatomic, strong) NSString *businessName;

+ (NSString *)parseClassName;

-(CLLocation *)convertGeoPointToCLLocation;

@end
