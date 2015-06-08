//
//  PinAnnotation.h
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-06.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "PinPFObject.h"

@interface PinAnnotation : MKPointAnnotation

@property (strong, nonatomic) NSString *businessName;
@property (strong, nonatomic) NSString *businessAddress;
@property (nonatomic, strong) PinPFObject *parseObject;
@property (nonatomic, strong) NSMutableArray *reviews;

-(instancetype)initWithPFObject:(PinPFObject*)pinPFObject;

@end
