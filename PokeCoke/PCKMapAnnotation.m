//
//  MAPAnnotation.m
//  Maps
//
//  Created by Ali Houshmand on 5/21/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "PCKMapAnnotation.h"

@implementation PCKMapAnnotation

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    
    self = [super init];
    if (self)
        
    {
        _coordinate = coordinate;  // _coordinate comes with property, using this to set
    }
    return self;
    
}


-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    _coordinate = newCoordinate;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
}
-(void)setSubtitle:(NSString *)subtitle
{
    _subtitle = subtitle;
    
}

@end
