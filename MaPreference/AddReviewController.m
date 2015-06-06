//
//  AddReviewController.m
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-02.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import "AddReviewController.h"
#import "PinPFObject.h"
#import "PinReviewPFObject.h"

@interface AddReviewController ()

@end

@implementation AddReviewController

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


- (void)saveReview:(PFUser *)currentUser {
    PinReviewPFObject *review = [PinReviewPFObject object];
    review.userReview = self.addReviewTextField.text;
    review.createdBy = currentUser.username;
    review.pinObjectID = self.pin.objectId;
    
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
            // Add reload map and reload tableview
        });
    }];
}

- (IBAction)addReviewDoneButton:(id)sender;
{   NSLog(@"Done button pressed");
    // using unwind segue to transition back to data view
    [self.view endEditing:YES];
    
    [self saveReview:self.currentUser];
    
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
