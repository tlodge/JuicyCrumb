//
//  CreateCliqueViewController.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 09/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CreateCliqueMapViewController.h"
#import "MapOverlayView.h"
#import "DDAnnotation.h"
#import "DDAnnotationView.h"

@interface CreateCliqueMapViewController()
-(void) createMap;
@end

@implementation CreateCliqueMapViewController

@synthesize mapAnnotations;
@synthesize mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"am here.....");
        /*int PADDINGX = 10;
        UIColor* backgroundcolor = RGBCOLOR(158, 163, 172);
        [self.view setBackgroundColor:backgroundcolor];
       
        
        
        CGRect frame = CGRectMake(PADDINGX, 10, self.view.width-20, 50);
        TTStyledTextLabel* development = [[[TTStyledTextLabel alloc] initWithFrame:frame] autorelease];
        development.tag = 42;
        development.font = [UIFont systemFontOfSize:22];
        [development setBackgroundColor:[UIColor clearColor]];
        development.html = @"Development Name";
        [self.view addSubview:development];
        
        TTView* aView = [[[TTView alloc] initWithFrame:CGRectMake(PADDINGX,40,self.view.frame.size.width-(2*PADDINGX),30)] autorelease];
        
        [aView setBackgroundColor:[UIColor clearColor]];
        
        aView.style = [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:10] next:
         [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
          [TTSolidBorderStyle styleWithColor:[UIColor blackColor] width:1 next:nil]]];
        
               UITextField *aTextField = [[UITextField alloc] initWithFrame:CGRectMake(2,12,self.view.frame.size.width-(15 + (PADDINGX)), 85)];
        aTextField.text = @"";
        
        [aView addSubview:aTextField];
        [self.view addSubview:aView];*/
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)dismiss {
    [self dismissModalViewControllerAnimated:YES];
}

-(void) create{
    NSLog(@"would create it here....");
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	
	// NOTE: This is optional, DDAnnotationCoordinateDidChangeNotification only fired in iPhone OS 3, not in iOS 4.
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(coordinateChanged_:) name:@"DDAnnotationCoordinateDidChangeNotification" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
	
	[super viewWillDisappear:animated];
	
	// NOTE: This is optional, DDAnnotationCoordinateDidChangeNotification only fired in iPhone OS 3, not in iOS 4.
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"DDAnnotationCoordinateDidChangeNotification" object:nil];	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor* black = RGBCOLOR(158, 163, 172);
    
    self.title = @"Create new Clique";
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
                                              initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered
     
     target:self action:@selector(dismiss)] autorelease];
   
    
    self.navigationItem.rightBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered
                                     target:self action:@selector(addCliqueDetails)] autorelease];

    
    
    [self createMap];
    
    
    TTView* aView = [[[TTView alloc] initWithFrame:CGRectMake(20,/*365*/0,self.view.frame.size.width-40,50)] autorelease];
    
    [aView setBackgroundColor:[UIColor clearColor]];
    
    aView.style =  [TTShapeStyle styleWithShape:[TTSpeechBubbleShape shapeWithRadius:5 pointLocation:60
                                                                          pointAngle:90
                                                                           pointSize:CGSizeMake(20,10)] next:
                    [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
                     [TTSolidBorderStyle styleWithColor:black width:1 next:nil]]];
    
    
    
    
    /*
    [TTShapeStyle styleWithShape:[TTSpeechBubbleShape shapeWithRadius:5 pointLocation:290
                                                                          pointAngle:270
                                                                           pointSize:CGSizeMake(20,10)] next:
                    [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
                     [TTSolidBorderStyle styleWithColor:black width:1 next:nil]]];  */
    
    
    
    CGRect frame = CGRectMake(20,20,aView.frame.size.width, aView.frame.size.height);
    TTStyledTextLabel* help = [[[TTStyledTextLabel alloc] initWithFrame:frame] autorelease];
    //help.tag = 42;
    
    help.font = [UIFont systemFontOfSize:15];
    help.html = @"Please select your clique's location";
    [help setBackgroundColor:[UIColor clearColor]];    
    [aView addSubview:help];
    
   // MapOverlayView* mview = [[MapOverlayView alloc] initWithFrame: mapView.frame];
    //[self.view addSubview:mview];
    //[mview addSubview:mapView];
    
   
    
    
    [self.view addSubview:mapView];
    [self.view addSubview:aView];
}

-(void) addCliqueDetails{
    TTOpenURL([NSString stringWithFormat:@"tt://clique/create/%f/%f", longitude, latitude]);
}

-(void) createMap{
    
    latitude = 51.504615;
    longitude = -0.020857;
    
    //self.mapAnnotations = [[NSMutableArray alloc] init];
    mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.mapType = MKMapTypeStandard;   // also MKMapTypeSatellite or MKMapTypeHybrid
    mapView.delegate = self;
    MKCoordinateRegion newRegion;
    
    newRegion.center.latitude = latitude;
    newRegion.center.longitude = longitude;
    newRegion.span.latitudeDelta = 0.02;
    newRegion.span.longitudeDelta = 0.02;
    
    CLLocationCoordinate2D theCoordinate;
	theCoordinate.latitude = latitude;
    theCoordinate.longitude = longitude;
    
    
    [mapView setRegion:newRegion animated:YES];
    
    DDAnnotation *annotation = [[[DDAnnotation alloc] initWithCoordinate:theCoordinate addressDictionary:nil] autorelease];
	annotation.title = @"Drag to Move Pin";
	annotation.subtitle = [NSString	stringWithFormat:@"%f %f", annotation.coordinate.latitude, annotation.coordinate.longitude];
	
	[self.mapView addAnnotation:annotation];	
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

#pragma mark -
#pragma mark DDAnnotationCoordinateDidChangeNotification

// NOTE: DDAnnotationCoordinateDidChangeNotification won't fire in iOS 4, use -mapView:annotationView:didChangeDragState:fromOldState: instead.
- (void)coordinateChanged_:(NSNotification *)notification {
	
	DDAnnotation *annotation = notification.object;
    latitude    = annotation.coordinate.latitude;
    longitude   = annotation.coordinate.longitude;
    
	annotation.subtitle = [NSString	stringWithFormat:@"%f %f", annotation.coordinate.latitude, annotation.coordinate.longitude];
}

#pragma mark -
#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
	
	if (oldState == MKAnnotationViewDragStateDragging) {
		DDAnnotation *annotation = (DDAnnotation *)annotationView.annotation;
        latitude    = annotation.coordinate.latitude;
        longitude   = annotation.coordinate.longitude;
		annotation.subtitle = [NSString	stringWithFormat:@"%f %f", annotation.coordinate.latitude, annotation.coordinate.longitude];		
	}
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;		
	}
	
	static NSString * const kPinAnnotationIdentifier = @"PinIdentifier";
	MKAnnotationView *draggablePinView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:kPinAnnotationIdentifier];
	
	if (draggablePinView) {
		draggablePinView.annotation = annotation;
	} else {
		// Use class method to create DDAnnotationView (on iOS 3) or built-in draggble MKPinAnnotationView (on iOS 4).
		draggablePinView = [DDAnnotationView annotationViewWithAnnotation:annotation reuseIdentifier:kPinAnnotationIdentifier mapView:self.mapView];
        
		if ([draggablePinView isKindOfClass:[DDAnnotationView class]]) {
			// draggablePinView is DDAnnotationView on iOS 3.
		} else {
			// draggablePinView instance will be built-in draggable MKPinAnnotationView when running on iOS 4.
		}
	}		
	
	return draggablePinView;
}


@end
