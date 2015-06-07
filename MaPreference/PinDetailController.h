//
//  PinDetailController.h
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-02.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface PinDetailController : UITableViewController


@property (strong, nonatomic) MKAnnotationView *annotation;

- (IBAction)unwindToPinDetail:(UIStoryboardSegue*)sender;

@end
