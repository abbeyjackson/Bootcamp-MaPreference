//
//  PinReviewPFObject.h
//  MaPreference
//
//  Created by Abegael Jackson & Oliver Andrews on 2015-06-05.
//  Copyright (c) 2015 Abegael Jackson & Oliver Andrews. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "PinPFObject.h"


@interface PinReviewPFObject : PFObject<PFSubclassing>


@property (nonatomic, strong) NSString *userReview;
@property (nonatomic, strong) NSString *createdBy;
@property (nonatomic, strong) PinPFObject *pinObject;


+ (NSString *)parseClassName;


@end
