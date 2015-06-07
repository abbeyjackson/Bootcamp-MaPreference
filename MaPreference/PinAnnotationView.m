//
//  PinAnnotationView.m
//  MaPreference
//
//  Created by Oliver Andrews on 2015-06-06.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import "PinAnnotationView.h"

@interface PinAnnotationView ()

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, strong) PFObject *object;
@property (nonatomic, assign) MKPinAnnotationColor pinColor;

@end

@implementation PinAnnotationView 

#pragma mark -
#pragma mark Init

//- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate
//                          andTitle:(NSString *)title
//                       andSubtitle:(NSString *)subtitle {
//    self = [super init];
//    if (self) {
//        self.coordinate = coordinate;
//        self.title = title;
//        self.subtitle = subtitle;
//    }
//    return self;
//}

//- (instancetype)initWithPFObject:(PFObject *)object {
//    PFGeoPoint *geoPoint = object[@"location"];
//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
//    NSString *title = object[@"businessName"];
//    NSString *subtitle = object[@"addressString"];
//    
//    self = [self initWithCoordinate:coordinate andTitle:title andSubtitle:subtitle];
//    if (self) {   
//        self.object = object;
//    }
//    return self;
//}

#pragma mark -
#pragma mark Equal

//- (BOOL)isEqual:(id)other {
//    if (![other isKindOfClass:[PinAnnotationView class]]) {
//        return NO;
//    }
//    
//    PinAnnotationView *annView = (PinAnnotationView *)other;
//    
//    if (annView.object && self.object) {
//        // We have a PFObject inside the PAWPost, use that instead.
//        return [annView.object.objectId isEqualToString:self.object.objectId];
//    }
//    
//    // Fallback to properties
//    return ([annView.title isEqualToString:self.title] &&
//            [annView.subtitle isEqualToString:self.subtitle] &&
//            annView.coordinate.latitude == self.coordinate.latitude &&
//            annView.coordinate.longitude == self.coordinate.longitude);
//}

#pragma mark -
#pragma mark Accessors

//- (void)setTitleAndSubtitleOutsideDistance:(BOOL)outside {
//    if (outside) {
//        self.title = nil;
//        self.subtitle = nil;
//        self.pinColor = MKPinAnnotationColorRed;
//    } else {
//        self.title = self.object[PAWParsePostTextKey];
//        self.subtitle = self.object[PAWParsePostUserKey][PAWParsePostNameKey] ?:
//        self.object[PAWParsePostUserKey][PAWParsePostUsernameKey];
//        self.pinColor = MKPinAnnotationColorGreen;
//    }
//}

//
//+ (MKAnnotationView *)createViewAnnotationForMapView:(MKMapView *)mapView annotation:(id <MKAnnotation>)annotation
//{
//    // try to dequeue an existing pin view first
//    MKAnnotationView *returnedAnnotationView =
//    [mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([PinAnnotationView class])];
//    if (returnedAnnotationView == nil)
//    {
//        returnedAnnotationView =
//        [[MKPinAnnotationView alloc] initWithAnnotation:annotation
//                                        reuseIdentifier:NSStringFromClass([PinAnnotationView class])];
//        
//        ((MKPinAnnotationView *)returnedAnnotationView).pinColor = MKPinAnnotationColorPurple;
//        ((MKPinAnnotationView *)returnedAnnotationView).animatesDrop = YES;
//        ((MKPinAnnotationView *)returnedAnnotationView).canShowCallout = YES;
//    }
//    
//    return returnedAnnotationView;
//}

@end
