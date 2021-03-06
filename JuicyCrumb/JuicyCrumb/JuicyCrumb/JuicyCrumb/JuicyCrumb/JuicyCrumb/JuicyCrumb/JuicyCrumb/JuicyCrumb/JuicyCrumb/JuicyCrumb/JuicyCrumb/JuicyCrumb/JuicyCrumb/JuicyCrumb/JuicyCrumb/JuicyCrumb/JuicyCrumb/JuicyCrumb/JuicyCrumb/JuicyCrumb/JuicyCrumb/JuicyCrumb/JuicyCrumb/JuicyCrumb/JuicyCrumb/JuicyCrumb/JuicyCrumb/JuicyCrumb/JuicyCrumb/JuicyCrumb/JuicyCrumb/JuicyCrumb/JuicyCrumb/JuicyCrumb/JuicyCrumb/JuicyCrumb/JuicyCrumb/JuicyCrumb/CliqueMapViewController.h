//
//  CliqueMapViewController.h
//  JuicyCrumb
//
//  Created by Tom Lodge on 20/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>



@interface CliqueMapViewController : TTViewController <MKMapViewDelegate> {
    MKMapView *mapView;
    NSMutableArray *mapAnnotations;
}

@property(nonatomic, retain) NSMutableArray* mapAnnotations;

@end
