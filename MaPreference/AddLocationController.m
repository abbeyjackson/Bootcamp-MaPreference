//
//  AddLocationController.m
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-02.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import "AddLocationController.h"
#import <CoreLocation/CoreLocation.h>
#import "Constants.h"
#import "PinPFObject.h"
#import "DataViewController.h"


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

- (void)savePinPFObject:(PFGeoPoint *)geoPoint
{
    PFUser *currentUser = [PFUser currentUser];
    PinPFObject *pin = [PinPFObject object];
    pin.userID = currentUser.objectId;
    pin.businessName = self.addLocationNameLabel.text;
    pin.usernameString = currentUser.username;
    pin.location = geoPoint;
    
    [pin saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (succeeded) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // Add reload map and reload tableview
        });
    }];
}

- (IBAction)addLocationDoneButton:(id)sender;
{   NSLog(@"Done button pressed");
    // using unwind segue to transition back to data view
    [self.view endEditing:YES];
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            [self savePinPFObject:geoPoint];
        }
    }];
    
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
