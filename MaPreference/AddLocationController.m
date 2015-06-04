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
    
    PinLocation *pinObject = [PinLocation objectWithClassName:AddLocationClassName];
    pinObject.ad
    
    // Create a PFObject using the Post class and set the values we extracted above
    PFObject *postObject = [PFObject objectWithClassName:PAWParsePostsClassName];
    postObject[PAWParsePostTextKey] = self.textView.text;
    postObject[PAWParsePostUserKey] = user;
    postObject[PAWParsePostLocationKey] = currentPoint;
    
    // Use PFACL to restrict future modifications to this object.
    PFACL *readOnlyACL = [PFACL ACL];
    [readOnlyACL setPublicReadAccess:YES];
    [readOnlyACL setPublicWriteAccess:NO];
    postObject.ACL = readOnlyACL;
    ...
    
    
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
