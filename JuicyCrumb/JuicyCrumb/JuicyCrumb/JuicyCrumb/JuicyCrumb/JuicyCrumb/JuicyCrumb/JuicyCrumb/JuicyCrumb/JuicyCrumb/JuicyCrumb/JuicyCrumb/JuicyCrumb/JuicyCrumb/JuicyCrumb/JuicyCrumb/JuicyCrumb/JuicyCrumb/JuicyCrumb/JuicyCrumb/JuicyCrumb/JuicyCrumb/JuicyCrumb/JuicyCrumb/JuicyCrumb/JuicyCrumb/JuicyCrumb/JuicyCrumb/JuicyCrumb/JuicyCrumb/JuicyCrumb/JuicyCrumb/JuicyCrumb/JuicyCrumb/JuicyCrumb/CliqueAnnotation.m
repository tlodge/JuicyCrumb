//
//  CliqueAnnotation.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 23/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CliqueAnnotation.h"


@implementation CliqueAnnotation

@synthesize title;
@synthesize subtitle;
@synthesize cliqueid;
@synthesize coords;


- (id)initWithCoordinatesAndTitle: (CLLocationCoordinate2D) lcd title:(NSString*) atitle subtitle:(NSString*)asubtitle clique:(NSString *) cid{
    
    if (self = [super init]) {
        self.coords = lcd;
        self.title = atitle;
        self.subtitle = asubtitle;
        cliqueid = cid;
        
    }
    return self;
}


- (CLLocationCoordinate2D)coordinate;
{
    return coords;
    /*CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = 51.486644;
    theCoordinate.longitude = -0.017467;
    return theCoordinate; */
}

// required if you set the MKPinAnnotationView's "canShowCallout" property to YES
- (NSString *)title
{
    return title;//@"Langbourne Place";
}

// optional
- (NSString *)subtitle
{
    return subtitle;// @"Posh riverside flats";
}

- (void)dealloc
{
    [super dealloc];
}

@end
