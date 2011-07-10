//
//  CliqueAnnotation.h
//  JuicyCrumb
//
//  Created by Tom Lodge on 23/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <MapKit/MapKit.h>

@interface CliqueAnnotation : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coords;
    NSString *title;
    NSString *subtitle;
    NSString *cliqueid;
}

@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *subtitle;
@property(nonatomic, retain) NSString *cliqueid;
@property(nonatomic, assign) CLLocationCoordinate2D coords;

- (id)initWithCoordinatesAndTitle: (CLLocationCoordinate2D) lcd title:(NSString*) atitle subtitle:(NSString*)asubtitle clique:(NSString *) cliqueid;

@end
