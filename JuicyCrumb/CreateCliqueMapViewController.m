//
//  CreateCliqueViewController.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 09/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CreateCliqueViewController.h"

@interface CreateCliqueMapViewController()
-(void) createMap;
@end

@implementation CreateCliqueMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Create new Clique";
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
                                              initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered
                                              target:self action:@selector(dismiss)] autorelease];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithTitle:@"Create" style:UIBarButtonItemStyleDone
                                               target:self action:@selector(create)] autorelease];
    [self createMap];
    [self.view addSubview:mapView];
}


-(void) createMap{
    
    //self.mapAnnotations = [[NSMutableArray alloc] init];
    mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.mapType = MKMapTypeStandard;   // also MKMapTypeSatellite or MKMapTypeHybrid
    mapView.delegate = self;
    MKCoordinateRegion newRegion;
    
    newRegion.center.latitude = 51.504615;
    newRegion.center.longitude = -0.020857;
    newRegion.span.latitudeDelta = 0.02;
    newRegion.span.longitudeDelta = 0.02;
    
    [mapView setRegion:newRegion animated:YES];
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
