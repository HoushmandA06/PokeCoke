//
//  MAPAnnotation.h
//  Maps
//
//  Created by Ali Houshmand on 5/21/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PCKMapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;  // since readonly, cant set

@property (nonatomic, readonly, copy) NSString * title;
@property (nonatomic, readonly, copy) NSString * subtitle;

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;  // how are these used in MAPVc
-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

-(void)setTitle:(NSString *)title;
-(void)setSubtitle:(NSString *)subtitle;


@end
