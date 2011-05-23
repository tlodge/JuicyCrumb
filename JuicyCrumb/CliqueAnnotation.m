//
//  CliqueAnnotation.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 23/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CliqueAnnotation.h"


@implementation CliqueAnnotation

- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = 51.486644;
    theCoordinate.longitude = -0.017467;
    return theCoordinate; 
}

// required if you set the MKPinAnnotationView's "canShowCallout" property to YES
- (NSString *)title
{
    return @"Langbourne Place";
}

// optional
- (NSString *)subtitle
{
    return @"Posh riverside flats";
}

- (void)dealloc
{
    [super dealloc];
}

@end
