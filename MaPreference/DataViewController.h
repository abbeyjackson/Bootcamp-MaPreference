//
//  DataViewController.h
//  MaPreference
//
//  Created by Abegael Jackson & Oliver Andrews on 2015-06-02.
//  Copyright (c) 2015 Abegael Jackson & Oliver Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class PinPFObject;
@class PFGeoPoint;


@interface DataViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *dataMapListToggleButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *locationListTableView;


@property (strong, nonatomic) PFGeoPoint *currentLocation;
@property (strong, nonatomic) PinPFObject *pin;
@property (strong, nonatomic) NSMutableArray *nearbyPins;
@property (strong, nonatomic) NSMutableArray *reviewsForPin;


- (IBAction)unwindToDataView:(UIStoryboardSegue*)sender;

-(void)getNearbyPins;


@end
