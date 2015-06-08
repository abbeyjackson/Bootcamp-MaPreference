//
//  AddReviewController.m
//  MaPreference
//
//  Created by Abegael Jackson & Oliver Andrews on 2015-06-02.
//  Copyright (c) 2015 Abegael Jackson & Oliver Andrews. All rights reserved.
//

#import "AddReviewController.h"
#import "PinPFObject.h"
#import "PinReviewPFObject.h"


@interface AddReviewController ()


@end

@implementation AddReviewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = [PFUser currentUser];
    
    [self.addReviewTextField.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.addReviewTextField.layer setBorderWidth:1.0];
    self.addReviewTextField.layer.cornerRadius = 5.0;
    self.addReviewTextField.clipsToBounds = YES;
    
    self.addReviewAddressLabel.text = self.pin.addressString;
    self.addReviewNameLabel.text = self.pin.businessName;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)saveReview:(PFUser *)currentUser {
    PinReviewPFObject *review = [PinReviewPFObject object];
    review.userReview = self.addReviewTextField.text;
    review.createdBy = currentUser.username;
    review.pinObject = self.pin;
    
    [review saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        
        if (succeeded) {
            NSString *successString = @"Thank you for adding a review!";
            UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"Success" message:successString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [successAlertView show];
        }
        else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    }];
}


- (IBAction)addReviewDoneButton:(id)sender;
{
    // NSLog(@"Done button pressed");
    [self.view endEditing:YES];
    [self saveReview:self.currentUser];
}


@end
