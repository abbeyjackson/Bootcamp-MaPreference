//
//  PinLocation.m
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-04.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import "PinLocation.h"
#import <Parse/PFObject+Subclass.h>

@implementation PinLocation 


@dynamic addLocationUserKey;
@dynamic addLocationPinLocationKey;
@dynamic addLocationReviewKey;
@dynamic addLocationAddressKey;
@dynamic addLocationNameKey;


+ (void)load {
    [self registerSubclass];
}

+ (NSString *) parseClassName{
    return @"PinLocation";
}

-(void)setup{
    self.addLocationUserKey = @"user";
    self.addLocationPinLocationKey = @"geoPoint";
    self.addLocationReviewKey = @"review";
    self.addLocationAddressKey = @"address";
    self.addLocationNameKey = @"name";

}

@end
