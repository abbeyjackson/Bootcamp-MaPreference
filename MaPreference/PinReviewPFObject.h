//
//  PinReviewPFObject.h
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-05.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface PinReviewPFObject : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *userReview;
@property (nonatomic, strong) NSString *createdBy;
@property (nonatomic, strong) NSString *pinObjectID;

+ (NSString *)parseClassName;

@end
