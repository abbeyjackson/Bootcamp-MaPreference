//
//  DataViewController.m
//  MaPreference
//
//  Created by Abegael Jackson & Oliver Andrews on 2015-06-02.
//  Copyright (c) 2015 Abegael Jackson & Oliver Andrews. All rights reserved.
//

#import "DataViewController.h"
#import <Parse/Parse.h>
#import "AddLocationController.h"
#import "ListViewCell.h"
#import "PinPFObject.h"
#import "PinDetailController.h"
#import "PinAnnotation.h"


@interface DataViewController ()<MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>{
    CLLocationManager *_locationManager;
    bool initialLocationSet;
}


@end


@implementation DataViewController


NSString *locationButtonText = @"List Locations";
NSString *mapButtonText = @"Show Map";


#pragma mark - View with User Current Location

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentLocation = [PFGeoPoint geoPoint];
    self.nearbyPins = [NSMutableArray array];
    self.reviewsForPin = [NSMutableArray array];
    [self loadRootView];
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
    
    [self getNearbyPins];
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKAnnotationView* annotationView = [mapView viewForAnnotation:userLocation];
    annotationView.canShowCallout = NO;
}


- (IBAction)logoutUser:(id)sender {
    [PFUser logOut];
    [self loadRootView];
}


-(void)getNearbyPins{
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        
        if (!error) {
            self.currentLocation = geoPoint;
            PFQuery *query = [PFQuery queryWithClassName:@"Location"];
            [query whereKey:@"location" nearGeoPoint:self.currentLocation withinKilometers:5.0];
            [query findObjectsInBackgroundWithBlock:^(NSArray *locations, NSError *error) {
                
                if (!error) {
                    self.nearbyPins = [NSMutableArray arrayWithArray:locations];
                    for (PinPFObject *location in locations) {
                        PinAnnotation *marker = [location makeAnnotation:location];
                        marker.title = location.businessName;
                        marker.subtitle = location.addressString;
                        [self.mapView addAnnotation:marker];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.mapView reloadInputViews];
                    });
                }
            }];
        }
    }];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"showPinDetail"]) {
        PinDetailController *destinationVC = [segue destinationViewController];
        
        if ([sender isKindOfClass:[PinAnnotation class]]) {
            PinAnnotation *annotationView = (PinAnnotation*) sender;
            destinationVC.locationObject = annotationView.parseObject;
        }
        else {
            destinationVC.locationObject = sender;
        }
    }
    
}

- (IBAction)unwindToDataView:(UIStoryboardSegue*)sender{
    [self.mapView reloadInputViews];
    [self.locationListTableView reloadData];
}

- (void)showAddLocationController{
    AddLocationController *addLocationController = [[AddLocationController alloc]init];
    [self.navigationController presentViewController:addLocationController animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if (annotation == self.mapView.userLocation){
        return nil;
    }
    
    static NSString* annotationIdentifier = @"pinObject";
    MKPinAnnotationView* pinView = (MKPinAnnotationView *)
    [self.mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    
    if (!pinView) {
        // if an existing pin view was not available, create one
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
    }
    
    pinView.canShowCallout = YES;
    pinView.pinColor = MKPinAnnotationColorRed;
    pinView.annotation = annotation;
    pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return pinView;
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    // NSLog(@"reuseIdentifier is %@", view.reuseIdentifier);
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    if ([view annotation]){
        PinAnnotation *pinAnnotation = view.annotation;
        [self performSegueWithIdentifier:@"showPinDetail" sender:pinAnnotation];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nearbyPins.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    ListViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"locationCell" forIndexPath:indexPath];
    PinPFObject *object = self.nearbyPins[indexPath.row];
    // NSLog(@"%ld", (long)indexPath.row);
    
    cell.listNameLabel.text = object.businessName;
    cell.listAddressLabel.text = object.addressString;
    double distanceTo = [object.location distanceInKilometersTo:self.currentLocation] * 1000;
    cell.listDistanceLabel.text = [NSString stringWithFormat:@"%.0f m", distanceTo];
    
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PinPFObject *pinObject = self.nearbyPins[indexPath.row];
    [self performSegueWithIdentifier:@"showPinDetail" sender:pinObject];
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
        [self.mapView reloadInputViews];
    }
}


@end
