//
//  PinLocation.h
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-04.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import <Parse/Parse.h>

@interface PinLocation : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString * addLocationUserKey;
@property (nonatomic, strong) NSString * addLocationPinLocationKey;
@property (nonatomic, strong) NSString * addLocationReviewKey;
@property (nonatomic, strong) NSString * addLocationAddressKey;
@property (nonatomic, strong) NSString * addLocationNameKey;

+ (NSString *)parseClassName;
-(void)setup;
@end
