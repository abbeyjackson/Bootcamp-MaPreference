//
//  PinDetailController.m
//  MaPreference
//
//  Created by Abegael Jackson & Oliver Andrews on 2015-06-02.
//  Copyright (c) 2015 Abegael Jackson & Oliver Andrews. All rights reserved.
//

#import "PinDetailController.h"
#import "LocationInfoCell.h"
#import "LocationReviewCell.h"
#import "PinPFObject.h"
#import "DataViewController.h"
#import "PinAnnotation.h"
#import "PinReviewPFObject.h"
#import "AddReviewController.h"

@interface PinDetailController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation PinDetailController



- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"PinPFObject: %@", self.locationObject);
    self.dateFormat = [[NSDateFormatter alloc] init];
    [self.dateFormat setDateFormat:@"yyyy-MM-dd"];
    self.reviewsForPin = [NSMutableArray array];
    [self getReviews];
}


-(void)getReviews{
        PFQuery *query = [PFQuery queryWithClassName:@"Review"];
        [query whereKey:@"pinObject" equalTo:self.locationObject];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            if (!error) {
                // NSLog(@"Successfully retrieved %lu review.", (unsigned long)objects.count);
                self.reviewsForPin = [NSMutableArray arrayWithArray:objects];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            } else {
                // NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.reviewsForPin.count;
}


- (IBAction)unwindToPinDetail:(UIStoryboardSegue*)sender{
    [self getReviews];
    [self.tableView reloadData];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showAddReview"]) {
        AddReviewController *destinationVC = [segue destinationViewController];
        destinationVC.pin = self.locationObject;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0) {
        return 90.0;
    }
    return 150.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section == 0) {
        
        LocationInfoCell *locationCell = [tableView dequeueReusableCellWithIdentifier:@"locationInfoCell" forIndexPath:indexPath];
        locationCell.locationNameLabel.text = self.locationObject.businessName;
        locationCell.locationAddressLabel.text = self.locationObject.addressString;
        
        return locationCell;
    }
    else {
        LocationReviewCell *reviewCell = [tableView dequeueReusableCellWithIdentifier:@"locationReviewCell" forIndexPath:indexPath];
        PinReviewPFObject *reviewObject = self.reviewsForPin[indexPath.row];
        reviewCell.reviewTextLabel.text = reviewObject.userReview;
        
        NSString *username = reviewObject.createdBy;
        NSString *dateString = [self.dateFormat stringFromDate:reviewObject.createdAt];
        NSString *reviewUsernameDateString = [NSString stringWithFormat:@"Submitted by %@ on %@", username, dateString];
        reviewCell.reviewUsernameDateLabel.text = reviewUsernameDateString;
        
        return reviewCell;
    }
}


@end
