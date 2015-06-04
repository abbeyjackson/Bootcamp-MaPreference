//
//  SignUpViewController.m
//  MaPreference
//
//  Created by Oliver Andrews on 2015-06-03.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import "SignupViewController.h"
#import <Parse/Parse.h>
#import "LoginViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)signup:(id)sender {
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] < 1 || [password length] < 1 || [email length] < 1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"Please fill all three fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertView show];
    }
    else {
        PFUser *user = [PFUser user];
        user.username = username;
        user.password = password;
        user.email = email;
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                // Hooray! Let them use the app now.
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            } else {
                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                // Show the errorString som ewhere and let the user try again.
                
                [errorAlert show];
            }
        }];
        
        
    }
    
}

@end
