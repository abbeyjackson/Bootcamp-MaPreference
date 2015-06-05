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

@property (nonatomic, strong) NSString *usernameString;
@property (nonatomic, strong) PFGeoPoint *location;
@property (nonatomic, strong) NSString *businessName;
@property (nonatomic, strong) NSString *userID;

+ (NSString *)parseClassName;

-(CLLocation *)convertGeoPointToCLLocation;

@end
