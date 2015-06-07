//
//  PinAnnotation.m
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-06.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import "PinAnnotation.h"

@implementation PinAnnotation


-(instancetype)initWithPFObject:(PinPFObject*)pinPFObject{
    self = [super init];
    if (self){
        
        _businessName = pinPFObject.businessName;
        _businessAddress = pinPFObject.addressString;
        _parseObjectID = pinPFObject.objectId;
        _reviews = [[NSMutableArray alloc]initWithArray:pinPFObject.reviews];
    }
    return self;
}


@end
