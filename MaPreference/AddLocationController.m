//
//  AddLocationController.m
//  MaPreference
//
//  Created by Abegael Jackson & Oliver Andrews on 2015-06-02.
//  Copyright (c) 2015 Abegael Jackson & Oliver Andrews. All rights reserved.
//

#import "AddLocationController.h"
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import "PinPFObject.h"
#import "DataViewController.h"
#import "PinReviewPFObject.h"


@interface AddLocationController ()


@end


@implementation AddLocationController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = [PFUser currentUser];
    self.pin = [PinPFObject object];
    [self.addLocationReviewField.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.addLocationReviewField.layer setBorderWidth:1.0];
    self.addLocationReviewField.layer.cornerRadius = 5.0;
    self.addLocationReviewField.clipsToBounds = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)saveReview:(PFUser *)currentUser isAlsoAddingPin:(BOOL)isAddingPin {
    PinReviewPFObject *review = [PinReviewPFObject object];
    review.userReview = self.addLocationReviewField.text;
    review.createdBy = currentUser.username;
    review.pinObject = self.pin;
    [review saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        
        if (error) {
            // NSLog(@"error in review save is %@", error);
        }
    }];
}


- (void)savePinPFObject:(PFGeoPoint *)geoPoint{
    self.pin.userID = self.currentUser.objectId;
    self.pin.businessName = self.addLocationNameLabel.text;
    self.pin.usernameString = self.currentUser.username;
    self.pin.location = geoPoint;
    self.pin.addressString = self.addLocationAddressLabel.text;
    [self.pin saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        
        if (succeeded) {
            NSString *successString = @"Thank you for adding a location!";
            UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"Success" message:successString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [successAlertView show];
            [self saveReview:self.currentUser isAlsoAddingPin:YES];
        }
        else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
}


- (IBAction)addLocationDoneButton:(id)sender{
    // NSLog(@"Done button pressed");
    [self.view endEditing:YES];
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        
        if (!error) {
            [self savePinPFObject:geoPoint];
        }
    }];
}


@end
