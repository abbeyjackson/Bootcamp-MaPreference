//
//  AddLocationController.m
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-02.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import "AddLocationController.h"
#import <CoreLocation/CoreLocation.h>
#import "PinLocation.h"
#import "Constants.h"


@interface AddLocationController ()

@end

@implementation AddLocationController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addLocationDoneButton:(id)sender;
{
    // Dismiss keyboard and capture any auto-correct
    [self resignFirstResponder];
    
    
    // Get the currently logged in PFUser
    PFUser *user = [PFUser currentUser];
    
    // Get user's current location
    CLLocation *currentLocation = [self.dataSource currentLocationForAddLocationController:self];
    CLLocationCoordinate2D currentCoordinate = currentLocation.coordinate;
    
    // Create a PFGeoPoint using the user's location
    PFGeoPoint *currentPoint = [PFGeoPoint geoPointWithLatitude:currentCoordinate.latitude
                                                      longitude:currentCoordinate.longitude];
    
    PinLocation *pinObject = [PinLocation objectWithClassName:addLocationClassName];
    pinObject.addLocationNameKey = self.addLocationNameLabel.text;
    pinObject.addLocationAddressKey = self.addLocationAddressLabel.text;
    pinObject.addLocationReviewKey = self.addLocationReviewField.text;
    pinObject.addLocationUserKey = user;
    pinObject.addLocationPinLocationKey = currentPoint;
    
    // Use PFACL to restrict future modifications to this object.
    PFACL *readOnlyACL = [PFACL ACL];
    [readOnlyACL setPublicReadAccess:YES];
    [readOnlyACL setPublicWriteAccess:NO];
    pinObject.ACL = readOnlyACL;

    
    [pinObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {  // Failed to save, show an alert view with the error message
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error userInfo][@"error"]
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"Ok", nil];
            [alertView show];
            return;
        }
        if (succeeded) {  // Successfully saved, post a notification to tell other view controllers
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:addLocationCreatedNotification
                 object:nil];
            });
        } else {
            NSLog(@"Failed to save.");
        }
    }];
    
    // Dismiss this view controller and return to the main view
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
