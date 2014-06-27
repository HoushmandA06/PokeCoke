//
//  MAPViewController.m
//  Maps
//
//  Created by Ali Houshmand on 5/21/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "PCKMapViewController.h"
#import "PCKMapAnnotation.h"
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PCKViewController.h"


@interface PCKMapViewController () <CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@end

@implementation PCKMapViewController
{
    CLLocationManager * lManager; // has an array of locations
    MKMapView * myMapView;
    UITextField * email;
    
    UIAlertView *alertViewOne;
    UIAlertView *alertViewTwo;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
 
        lManager = [[CLLocationManager alloc] init];
        lManager.delegate = self;
        
        lManager.distanceFilter = 20;
        lManager.desiredAccuracy = kCLLocationAccuracyBest;  //kCLLocationAccuracyNearestTenMeters;
        
        
        [lManager startUpdatingLocation];
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    myMapView = [[MKMapView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
    
    myMapView.delegate = self;
    
    [self.view addSubview:myMapView];
    [self.view sendSubviewToBack:myMapView];


//// NO NEED FOR TAP RECOGNIZER SINCE NOT ADDING PINS
//    UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPinToMap:)];
//    singleTapRecognizer.numberOfTapsRequired = 1;
//  [myMapView addGestureRecognizer:singleTapRecognizer];
    
    
    email = [[UITextField alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,50)];
    email.placeholder = @"ENTER E-MAIL FOR REWARD";
    email.backgroundColor = HEADER_COLOR;
    email.keyboardType = UIKeyboardTypeEmailAddress;
    email.autocorrectionType = UITextAutocorrectionTypeNo;
    email.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
    email.leftViewMode = UITextFieldViewModeAlways;
    email.alpha = .80;
    email.textColor = [UIColor blackColor];
    email.font = [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:20];
    email.delegate = self;
    [self.view addSubview:email];
    
    self.productName = [[UILabel alloc] initWithFrame:CGRectMake(0,email.frame.origin.y+52,SCREEN_WIDTH,50)];
    self.productName.text = @"Missing Product"; // to be replaced by CLLocation address
    self.productName.textAlignment = NSTextAlignmentCenter;
    self.productName.backgroundColor = HEADER_COLOR;
    self.productName.alpha = .80;
    self.productName.textColor = [UIColor whiteColor];
    self.productName.font = [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:20];
    [self.view addSubview:self.productName];
    
    self.addressField = [[UILabel alloc] initWithFrame:CGRectMake(0,email.frame.origin.y+104,SCREEN_WIDTH,50)];
    self.addressField.text = @"Store Address"; // to be replaced by CLLocation address
    self.addressField.textAlignment = NSTextAlignmentCenter;
    self.addressField.alpha = .80;
    self.addressField.backgroundColor = HEADER_COLOR;
    self.addressField.textColor = [UIColor whiteColor];
    self.addressField.font = [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:20];
    [self.view addSubview:self.addressField];
    
    UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT-80,SCREEN_WIDTH,100)];
    footer.backgroundColor = HEADER_COLOR;
    footer.alpha = .40;
    [self.view addSubview:footer];
    
    UIButton * submit = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-105, SCREEN_HEIGHT-90, 100, 100)];
    [submit setImage:[UIImage imageNamed:@"plane"] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
    
    
    UIButton * home = [[UIButton alloc] initWithFrame:CGRectMake(5, SCREEN_HEIGHT-90, 100, 100)];
    [home setImage:[UIImage imageNamed:@"backHome"] forState:UIControlStateNormal];
    [home addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:home];

}



- (void)alertView:(UIAlertView *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if([actionSheet isEqual:alertViewOne] || [actionSheet isEqual:alertViewTwo])
    {
        if (buttonIndex == 0)
        {
            // PARSE SUBMISSION CODE HERE
            PFObject *product = [PFObject objectWithClassName:@"UserReport"];
            product[@"ProductName"]= self.productName.text;
            product[@"Email"]= email.text;
            product[@"address"] = self.addressField.text;
            // format CLLocation address to include city state (potentially)
            // add a lat/long object key
            
            [product saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                NSLog(@"%u",succeeded);
                
               }];
            
            NSInteger numberOfViewControllers = self.navigationController.viewControllers.count;
            if (numberOfViewControllers>0) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else if(numberOfViewControllers == 0){
                [self.navigationController popViewControllerAnimated:YES];
            }

        
        }
//        else
//        {
//            
//        }
        
    
//    } else if ([actionSheet isEqual:alertViewTwo])
//    {
//        NSLog(@"alertviewtwo selected");
//        //// experimental code:
//        
//        [self dismissViewControllerAnimated:NO completion:^{
//            UIViewController * popTo = nil;
//            NSArray * viewControllers = [self.navigationController viewControllers];
//            if (viewControllers && [viewControllers count] > 1) {
//                popTo = [viewControllers objectAtIndex:1];
//            }
//            
//            if (popTo) {
//                [self.navigationController popToViewController:popTo animated:YES];
//            } else {
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            }
//            
//        }];
//        
    }
    
}


-(void)submit
{
    
    if([email.text length] == 0)
        
    {
        alertViewOne = [[UIAlertView alloc] initWithTitle:@"Email is optional, but we can't send you a reward without it. Are you sure you want to submit?"  message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alertViewOne show];
        
    } else
    
    {
        // move alertViewTwo here
        alertViewTwo = [[UIAlertView alloc] initWithTitle:@"Thanks for the info! Expect a reward email in your inbox!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertViewTwo show];

    
    }
}


-(void)home
{

    NSInteger numberOfViewControllers = self.navigationController.viewControllers.count;
    
    if (numberOfViewControllers>0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
    }else if(numberOfViewControllers == 0){
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    [myMapView removeAnnotations:myMapView.annotations];

    
    for (CLLocation * location in locations)
    {
    
    PCKMapAnnotation * annotation = [[PCKMapAnnotation alloc] initWithCoordinate:location.coordinate];
    NSLog(@"%@", location);
        [myMapView addAnnotation:annotation];
        
    // [mapView setCenterCoordinate:location.coordinate animated:YES];

        MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(1.0,1.0));  //sets center AND zooms (MKCoordinateRegion)
        
        [myMapView setRegion:region animated:YES];
    
        annotation.title = @"Marker";
        annotation.subtitle = @"This is a marker";
        
        CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            NSLog(@"%@", placemarks);
            
            for (CLPlacemark * placemark in placemarks) {
                NSLog(@"%@", placemark);
               
                NSString * cityState = [NSString stringWithFormat:@"%@,%@",placemark.addressDictionary[@"City"],placemark.addressDictionary[@"State"]];
                
                
                NSString * numberStreet = [NSString stringWithFormat:@"%@ %@",placemark.subThoroughfare,placemark.thoroughfare];
                
                [annotation setTitle:placemark.thoroughfare];
                [annotation setSubtitle:cityState];
                
                self.addressField.text = numberStreet;
            }
            
     }];
    //  [mapView selectAnnotation:annotation animated:YES];  // makes annotation pop up auto
    
    }
// [lManager stopUpdatingLocation];
    
}


/*
- (void)addPinToMap:(UIGestureRecognizer *)gestureRecognizer
{
    
    CGPoint touchPoint = [gestureRecognizer locationInView:myMapView];
    
    
    CLLocationCoordinate2D touchMapCoordinate = [myMapView convertPoint:touchPoint toCoordinateFromView:myMapView];
    
    PCKMapAnnotation * toAdd = [[PCKMapAnnotation alloc]init];
    
    toAdd.coordinate = touchMapCoordinate;
    
    toAdd.subtitle = @"Subtitle";
    toAdd.title = @"Title";
    
    CLLocation * location = [[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"%@", placemarks);
        
        for (CLPlacemark * placemark in placemarks) {
            NSLog(@"%@", placemark);
            
            NSString * cityState = [NSString stringWithFormat:@"%@,%@",placemark.addressDictionary[@"City"],placemark.addressDictionary[@"State"]];
            
            [toAdd setTitle:placemark.thoroughfare];
            [toAdd setSubtitle:cityState];
        }
    }];
    [myMapView addAnnotation:toAdd];
}
*/



-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{

//    MKAnnotationView * annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
//    annotationView.image = [UIImage imageNamed:@"smilies_1"];    IF YOU WANT SPEC IMAGE FOR PIN
    
    MKAnnotationView * annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"annotationView"];
    
    if (annotationView == nil)
    {
    
   annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
        
    } else {
        
        annotationView.annotation = annotation;
    }
    
    annotationView.draggable = YES;
    annotationView.canShowCallout = YES;
    
    return annotationView;
    
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    NSLog(@"new state : %d and old state %d",(int)newState,(int)oldState);
    
    switch ((int)newState) {
        case 0: // not dragging
        {
            [mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
            
            CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
            CLLocation * location = [[CLLocation alloc] initWithLatitude:view.annotation.coordinate.latitude longitude:view.annotation.coordinate.longitude];
            
            [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
                NSLog(@"%@", placemarks);
                
                for (CLPlacemark * placemark in placemarks) {
                    NSLog(@"%@", placemark);
                    
                    NSString * cityState = [NSString stringWithFormat:@"%@,%@",placemark.addressDictionary[@"City"],placemark.addressDictionary[@"State"]];
                    
                    NSString * numberStreet = [NSString stringWithFormat:@"%@ %@",placemark.subThoroughfare,placemark.thoroughfare];
                    
                    [(PCKMapAnnotation *)view.annotation setTitle:placemark.thoroughfare];
                    [(PCKMapAnnotation *)view.annotation setSubtitle:cityState];
                    
                    self.addressField.text = numberStreet;
            

                }
                
            }];
        }
            break;
        case 1: // starting drag
            
            break;
        case 2: // dragging
            
            break;
        case 4: // ending drag
            
            break;
            
        default:
            break;
    }

}

-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.toolbarHidden = YES;
}


-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    view.canShowCallout = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
