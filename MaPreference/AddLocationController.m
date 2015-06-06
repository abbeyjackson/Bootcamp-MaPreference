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
#import "PinReviewPFObject.h"


@interface AddLocationController ()

@end

@implementation AddLocationController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.currentUser = [PFUser currentUser];
    self.pin = [PinPFObject object];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveReview:(PFUser *)currentUser isAlsoAddingPin:(BOOL)isAddingPin {
    PinReviewPFObject *review = [PinReviewPFObject object];
    review.userReview = self.addLocationReviewField.text;
    review.createdBy = currentUser.username;
    review.pinObjectID = self.pin.objectId;
    
    [review saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (succeeded) {
            
            if (isAddingPin) {
                
                self.pin.reviews = [NSMutableArray arrayWithObject:review];
                [self.pin saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
                    if (succeeded) {
                        
                        NSString *successString = @"Thank you for adding a location!";
                        UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"Success" message:successString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [successAlertView show];
                        
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

            if (!isAddingPin) {
                NSString *successString = @"Thank you for adding a review!";
                UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"Success" message:successString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [successAlertView show];
            }
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

/*-(void)getAddessInfo:(NSString*)address{

    CLGeocoder *geocoder = [[CLGeocoder alloc] init];

    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
            
        }
        else {
        CLPlacemark *pinPlacemark = [placemarks lastObject];
        }
    }];

}*/

- (void)savePinPFObject:(PFGeoPoint *)geoPoint
{
    self.pin.userID = self.currentUser.objectId;
    self.pin.businessName = self.addLocationNameLabel.text;
    self.pin.usernameString = self.currentUser.username;
    self.pin.location = geoPoint;
    self.pin.addressString = self.addLocationAddressLabel.text;
    
    [self saveReview:self.currentUser isAlsoAddingPin:YES];
    
    //[self getAddessInfo:self.addLocationAddressLabel.text];
    
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
