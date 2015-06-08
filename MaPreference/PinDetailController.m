//
//  PinDetailController.m
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-02.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSLog(@"Business name from viewDidLoad: %@", self.businessName);
    
    NSLog(@"Business name from viewDidLoad: %@", self.reviewIds);
    [self getReviews];
    
}

-(void)getReviews{
    
    for (NSString *string in self.reviewIds) {
//        
//        PinReviewPFObject *reviewObject = [PFObject objectWithoutDataWithClassName:@"Review" objectId:string];
//        [self.reviews addObject:[PinReviewPFObject objectWithoutDataWithClassName:@"Review" objectId:string]];
        NSLog(@"user review: %@", self.reviews[0]);
        
        
        
        PFQuery *query = [PFQuery queryWithClassName:@"Review"];
        [query whereKey:@"objectId" equalTo:string];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                NSLog(@"Successfully retrieved %lu review.", (unsigned long)objects.count);
                
                self.reviewsForPin = [NSMutableArray arrayWithArray:objects];
                
                PFQuery *query = [PFQuery queryWithClassName:@"Review"];
                [query whereKey:@"objectId" equalTo:string];
                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (!error) {
                        // The find succeeded.
                        NSLog(@"Successfully retrieved %lu review.", (unsigned long)objects.count);
                        
                        
                        self.reviewsForPin = [NSMutableArray arrayWithArray:objects];
                        
                        
                    } else {
                        // Log details of the failure
                        NSLog(@"Error: %@ %@", error, [error userInfo]);
                    }
                }];
                
                
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.reviews.count;
}

- (IBAction)unwindToPinDetail:(UIStoryboardSegue*)sender{
    
    // Pull any data from the view controller which initiated the unwind segue.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showAddReview"]) {
        //pass forward pin object
        AddReviewController *destinationVC = [segue destinationViewController];

        
    }
    
}


//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    self.annotation = [[PinAnnotation alloc]init];
    if (indexPath.section == 0) {

        LocationInfoCell *locationCell = [tableView dequeueReusableCellWithIdentifier:@"locationInfoCell" forIndexPath:indexPath];
        [locationCell.locationNameLabel setText:self.businessName];
        [locationCell.locationAddressLabel setText:self.businessAddress];

        return locationCell;
    } else {
        LocationReviewCell *reviewCell = [tableView dequeueReusableCellWithIdentifier:@"locationReviewCell" forIndexPath:indexPath];
        [reviewCell.reviewTextLabel setText:self.reviewsForPin[indexPath.row]];
        return reviewCell;
    }
    
    return nil;
}


@end
