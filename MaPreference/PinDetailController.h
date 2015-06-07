//
//  PinDetailController.h
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-02.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PinAnnotation;

@interface PinDetailController : UITableViewController


@property (strong, nonatomic) NSString *parseObjectID;

- (IBAction)unwindToPinDetail:(UIStoryboardSegue*)sender;

@end
