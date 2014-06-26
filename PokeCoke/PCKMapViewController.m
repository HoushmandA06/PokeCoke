//
//  MAPViewController.m
//  Maps
//
//  Created by Ali Houshmand on 5/21/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "PCKMapViewController.h"
#import "PCKMapAnnotation.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface PCKMapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@end

@implementation PCKMapViewController
{
    
    CLLocationManager * lManager; // has an array of locations
    MKMapView * myMapView;
    
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
    
    myMapView = [[MKMapView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height/2)];
    
    myMapView.delegate = self;
    
    [self.view addSubview:myMapView];
    

//// NO NEED FOR TAP RECOGNIZER SINCE NOT ADDING PINS
//    UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPinToMap:)];
//    singleTapRecognizer.numberOfTapsRequired = 1;
    
//  [myMapView addGestureRecognizer:singleTapRecognizer];
    
    
    // PROPERTY FOR ADDRESS FIELD, WILL NEED TO GET INFO FROM CLLOCATION THEN PASS ON TO CHILD VIEW (TVC PUSHED BY COKE BUTTON)
    
    self.addressField = [[UILabel alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height/2,self.view.frame.size.width,50)];
    self.addressField.text = @"Address Placeholder"; // to be replaced by CLLocation address
    self.addressField.textAlignment = NSTextAlignmentCenter;
    self.addressField.backgroundColor = HEADER_COLOR;
    self.addressField.textColor = [UIColor whiteColor];
    self.addressField.font = [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:20];
    [self.view addSubview:self.addressField];
    

    
    UIButton * pushTVC = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-75, self.view.frame.size.height/2+75, 150, 150)];
    [pushTVC setImage:[UIImage imageNamed:@"Coke"] forState:UIControlStateNormal];
    [pushTVC addTarget:self action:@selector(pushTVC) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:pushTVC];
    
    
}

-(void)pushTVC
{
    // code to push TVC init with navcontroller
    
    
    
    
    
}




-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    [myMapView removeAnnotations:myMapView.annotations];

    
    for (CLLocation * location in locations)
    {
    
    PCKMapAnnotation * annotation = [[PCKMapAnnotation alloc] initWithCoordinate:location.coordinate];
    NSLog(@"%@", location);
        [myMapView addAnnotation:annotation];
        
    //   [mapView setCenterCoordinate:location.coordinate animated:YES];
    //coordinate has lat and long

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




-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    view.canShowCallout = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
