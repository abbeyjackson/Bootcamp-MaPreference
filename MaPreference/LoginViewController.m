//
//  LoginViewController.m
//  MaPreference
//
//  Created by Oliver Andrews on 2015-06-03.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "SignUpViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UITextField *passwordView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]];
    self.loginView.layer.borderColor = [UIColor colorWithWhite:1.0f alpha:1.0f].CGColor;
    self.loginView.layer.borderWidth = 1.0f;
    
}

- (IBAction)login:(UIButton*)sender {
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 || [password length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"Please fill all fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertView show];
    }
    else
    {
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            if (error) {
                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                // Show the errorString somewhere and let the user try again.
                [errorAlert show];
            } else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
    
}


- (IBAction)unwindToLogin:(UIStoryboardSegue*)sender{
    
    // Pull any data from the view controller which initiated the unwind segue.
}


@end
