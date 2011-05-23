//
//  CliqueMapViewController.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 20/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CliqueMapViewController.h"
#import "CliqueAnnotation.h"

@interface CliqueMapViewController() 

-(void) addSomeDevelopments;

@end

@implementation CliqueMapViewController

@synthesize mapAnnotations;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Cliques";
    }
    return self;
}


- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


/* Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    
}*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
     
    [super viewDidLoad];
   

   
    
    [self addSomeDevelopments];
  
    
    [self.view addSubview:mapView];
}

-(void) addSomeDevelopments{
    
    self.mapAnnotations = [[NSMutableArray alloc] init];
    mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.mapType = MKMapTypeStandard;   // also MKMapTypeSatellite or MKMapTypeHybrid
    mapView.delegate = self;
    MKCoordinateRegion newRegion;
    
    newRegion.center.latitude = 51.504615;
    newRegion.center.longitude = -0.020857;
    newRegion.span.latitudeDelta = 0.02;
    newRegion.span.longitudeDelta = 0.02;
    
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = 51.486644;
    theCoordinate.longitude = -0.017467;
    
    [mapView setRegion:newRegion animated:YES];
    
    CliqueAnnotation *cliqueAnnotation = [[CliqueAnnotation alloc] initWithCoordinatesAndTitle: theCoordinate title:@"Langbournee Place" subtitle:@"Posh riverside flats" clique:@"Langbourne"
                                          ];
    [self.mapAnnotations addObject:cliqueAnnotation];
    [cliqueAnnotation release];
    
    theCoordinate.latitude = 51.488591;
    theCoordinate.longitude = -0.021801;

    cliqueAnnotation = [[CliqueAnnotation alloc] initWithCoordinatesAndTitle: theCoordinate title:@"Burrells Wharf" subtitle:@"Where ships were built" clique:@"Burrells"
                        ];
    [self.mapAnnotations addObject:cliqueAnnotation];
    [cliqueAnnotation release];

   
    theCoordinate.latitude = 51.504702;
    theCoordinate.longitude = -0.026865;

    cliqueAnnotation = [[CliqueAnnotation alloc] initWithCoordinatesAndTitle: theCoordinate title:@"Canary Riverside Place" subtitle:@"Uber Posh flats" clique:@"Canary Riverside"
                        ];
    [self.mapAnnotations addObject:cliqueAnnotation];
    [cliqueAnnotation release];

    for(CliqueAnnotation* ca in self.mapAnnotations){
        [mapView addAnnotation:ca];
    }
    
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    NSLog(@"ok am in her at least..");
    static NSString* CliqueAnnotationIdentifier = @"CliqueAnnotationIdentifier";
    MKPinAnnotationView* pinView = (MKPinAnnotationView *)
    [mapView dequeueReusableAnnotationViewWithIdentifier:CliqueAnnotationIdentifier];
    if (!pinView)
    {
        NSLog(@"creating a new pin view!");
        // if an existing pin view was not available, create one
        MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
                                               initWithAnnotation:annotation reuseIdentifier:CliqueAnnotationIdentifier] autorelease];
        customPinView.pinColor = MKPinAnnotationColorPurple;
        customPinView.animatesDrop = YES;
        customPinView.canShowCallout = YES;
        
        // add a detail disclosure button to the callout which will open a new view controller page
        //
        // note: you can assign a specific call out accessory view, or as MKMapViewDelegate you can implement:
        //  - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
        //
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton addTarget:self
                        action:@selector(showDetails:)
              forControlEvents:UIControlEventTouchUpInside];
        customPinView.rightCalloutAccessoryView = rightButton;
        
        return customPinView;
    }else
    {
        pinView.annotation = annotation;
    }
    return pinView;
}


- (void)showDetails:(id)sender{
        // the detail view does not want a toolbar so hide it
    //[self.navigationController setToolbarHidden:YES animated:NO];
        
    //[self.navigationController pushViewController:self.detailViewController animated:YES];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
