//
//  PinLocation.h
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-04.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import <Parse/Parse.h>

@interface PinLocation : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString * addLocationClassName;
@property (nonatomic, strong) NSString * addLocationUserKey;
@property (nonatomic, strong) NSString * addLocationUsernameKey;
@property (nonatomic, strong) NSString * addLocationTextKey;
@property (nonatomic, strong) NSString * addLocationLocationKey;
@property (nonatomic, strong) NSString * addLocationNameKey;

+ (NSString *)parseClassName;
-(void)setup;
@end
