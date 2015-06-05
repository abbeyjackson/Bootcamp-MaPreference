//
//  DataViewController.m
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-02.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import "DataViewController.h"
#import <Parse/Parse.h>
#import "AddLocationController.h"
#import "Constants.h"
#import "PinLocation.h"
#import "Location.h"
#import "ListViewCell.h"


@interface DataViewController ()<MKMapViewDelegate, CLLocationManagerDelegate, AddLocationControllerDataSource, UITableViewDataSource, UITableViewDelegate>{
    CLLocationManager *_locationManager;
    bool initialLocationSet;
}

@end

@implementation DataViewController

NSString *locationButtonText = @"List Locations";
NSString *mapButtonText = @"Show Map";
NSMutableArray *allPinLocations;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadRootView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(locationDidChange:)
                                                 name:currentLocationDidChangeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(postWasCreated:)
                                                 name:addLocationCreatedNotification
                                               object:nil];
}



-(void)loadRootView{
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSLog(@"Current User: %@", currentUser.username);
    }
    else {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    [self setInitialLocation];
}

-(void)setInitialLocation{
    
    [self myLocation];
    
    self.mapView.showsUserLocation = true;
    self.mapView.delegate = self;
    self.mapView.hidden = NO;
    self.locationListTableView.hidden = YES;
}

-(IBAction)mapListViewSwitchButton:(id)sender{
    if ([self.dataMapListToggleButton.titleLabel.text isEqualToString:locationButtonText]) {
        self.locationListTableView.hidden = NO;
        self.mapView.hidden = YES;
        [self.dataMapListToggleButton setTitle:mapButtonText forState:UIControlStateNormal];
        [self.locationListTableView reloadData];
    }
    else if ([self.dataMapListToggleButton.titleLabel.text isEqualToString:mapButtonText]) {
        self.locationListTableView.hidden = YES;
        self.mapView.hidden = NO;
        [self.dataMapListToggleButton setTitle:locationButtonText forState:UIControlStateNormal];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

     ListViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"locationCell" forIndexPath:indexPath];
    return cell;
}


- (void)setCurrentLocation:(CLLocation *)currentLocation {
    if (self.currentLocation == currentLocation) {
        return;

    }
    
    _currentLocation = currentLocation;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:currentLocationDidChangeNotification
                                                            object:nil
                                                          userInfo:@{ LocationKey : currentLocation } ];
    });
    // ...
}


- (void)locationDidChange:(NSNotification *)note {
    // Update the table with the new points
}


-(void)myLocation{
    initialLocationSet = NO;
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];
    _locationManager.delegate = self;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations firstObject];
    
    if (!initialLocationSet){
        
        MKCoordinateRegion startingRegion;
        CLLocationCoordinate2D loc = location.coordinate;
        startingRegion.center = loc;
        startingRegion.span.latitudeDelta = 0.02;
        startingRegion.span.longitudeDelta = 0.02;
        [self.mapView setRegion:startingRegion];
        
        initialLocationSet = YES;
    }
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:currentLocationDidChangeNotification
                                                  object:nil];
}

- (IBAction)unwindToDataView:(UIStoryboardSegue*)sender{
    
}

- (IBAction)logoutUser:(id)sender {
    [PFUser logOut];
    [self loadRootView];
}


- (void)showAddLocationController{
    AddLocationController *addLocationController = [[AddLocationController alloc]init];
    addLocationController.dataSource = self;
    [self.navigationController presentViewController:addLocationController animated:YES completion:nil];
}

- (CLLocation *)currentLocationForAddLocationController:(AddLocationController *)controller {
    return self.currentLocation;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
