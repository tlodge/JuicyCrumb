//
//  CliqueMapViewController.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 20/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CliqueMapViewController.h"
#import "CliqueAnnotation.h"
#import "NetworkManager.h"
#import "Clique.h"
#import "MapOverlayView.h"

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
        self.navigationItem.backBarButtonItem =
        [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered
                                         target:nil action:nil] autorelease];
      /*  self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                                   initWithTitle:@"Create New" style:UIBarButtonItemStyleDone
                                                   target:@"tt://clique/create/map" action:@selector(openURL)] autorelease];*/
        
    /*    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                                   initWithTitle:@"Respond!" style:UIBarButtonItemStyleDone
                                                   target:@"tt://order/food" action:@selector(openURL)] autorelease];*/
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
   
    self.title = @"Cliques";
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithTitle:@"Create New" style:UIBarButtonItemStyleDone
                                               target:@"tt://clique/create/map" action:@selector(openURL)] autorelease];
   
    
    [self addSomeDevelopments];
  
    [self.view addSubview:mapView];

    
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"in here...");
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
    theCoordinate.latitude = 51.504615;
    theCoordinate.longitude = -0.020857;
    [mapView setRegion:newRegion animated:YES];
    
    NSArray *cliques = [[NetworkManager sharedManager] surroundingCliques: theCoordinate radius:1.0];
    
    NSLog(@"great, clique size is %d", [cliques count]);
    for (Clique *clique in cliques){
       
        theCoordinate.latitude = clique.lat;
        theCoordinate.longitude = clique.lng;
        
        NSLog(@"got lat lng %f %f", clique.lat, clique.lng);
        CliqueAnnotation *cliqueAnnotation = [[CliqueAnnotation alloc] initWithCoordinatesAndTitle: theCoordinate title:clique.name subtitle:clique.tagline clique:clique.identity];
        [self.mapAnnotations addObject:cliqueAnnotation];
        [cliqueAnnotation release];
    }
    
    
    theCoordinate.latitude = 51.488591;
    theCoordinate.longitude = -0.021801;

    /*cliqueAnnotation = [[CliqueAnnotation alloc] initWithCoordinatesAndTitle: theCoordinate title:@"Burrells Wharf" subtitle:@"Where ships were built" clique:@"Burrells"
                        ];
    [self.mapAnnotations addObject:cliqueAnnotation];
    [cliqueAnnotation release];

   
    theCoordinate.latitude = 51.504702;
    theCoordinate.longitude = -0.026865;

    cliqueAnnotation = [[CliqueAnnotation alloc] initWithCoordinatesAndTitle: theCoordinate title:@"Canary Riverside Place" subtitle:@"Uber Posh flats" clique:@"Canary Riverside"
                        ];
    [self.mapAnnotations addObject:cliqueAnnotation];
    [cliqueAnnotation release];
     */
    
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
        
        [rightButton addTarget:@"tt://clique/join?cliqueid=langbourne" action:@selector(openURLFromButton:)
         forControlEvents:UIControlEventTouchUpInside];
        
        /*[rightButton addTarget:self
                        action:@selector(showDetails:)
              forControlEvents:UIControlEventTouchUpInside];*/
        
        
        
        
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
