//
//  PinDetailController.h
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-02.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinPFObject.h"

@interface PinDetailController : UITableViewController

@property (nonatomic, strong) PinPFObject *locationObject;
@property (strong, nonatomic) NSMutableArray *reviewsForPin;

@property (strong, nonatomic) NSDateFormatter *dateFormat;

- (IBAction)unwindToPinDetail:(UIStoryboardSegue*)sender;

@end
