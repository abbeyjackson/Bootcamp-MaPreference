//
//  DataViewController.h
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-02.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
//#import "AddLocationController.h"

@interface DataViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *dataMapListToggleButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *locationListTableView;

@property (strong, nonatomic) CLLocation *currentLocation;

@end
