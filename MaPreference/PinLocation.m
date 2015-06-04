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


@dynamic addLocationClassName;
@dynamic addLocationUserKey;
@dynamic addLocationUsernameKey;
@dynamic addLocationTextKey;
@dynamic addLocationLocationKey;
@dynamic addLocationNameKey;


+ (void)load {
    [self registerSubclass];
}

+ (NSString *) parseClassName{
    return @"PinLocation";
}

-(void)setup{
    self.addLocationClassName = @"pins";
    self.addLocationUserKey = @"user";
    self.addLocationUsernameKey = @"username";
    self.addLocationTextKey = @"text";
    self.addLocationLocationKey = @"location";
    self.addLocationNameKey = @"name";

}

@end
