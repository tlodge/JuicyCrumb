//
//  CreateCliqueDetailsViewController.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 13/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CreateCliqueDetailsViewController.h"


@implementation CreateCliqueDetailsViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
// TTModelViewController

- (void)createModel {
    
    UITextField* development = [[[UITextField alloc] init] autorelease];
    development.placeholder = @"Your development's name";
    development.font = TTSTYLEVAR(font);
    
    self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
                       @"Development",
                      development,
                       
                       @"Structure",
                       [TTTableTextItem itemWithText:@"Floors" URL:@"tt://clique/create/structure/floors"],
                       [TTTableTextItem itemWithText:@"Blocks" URL:@"tt://clique/create/structure/blocks"],

                       @"Joining details",
                       [TTTableTextItem itemWithText:@"Privacy" URL:@"tt://clique/create/development/joining/privacy"],
                       [TTTableTextItem itemWithText:@"Passswords" URL:@"tt://clique/create/development/joining/passwords"],
                       nil];
}

-(id) initWithLat:(double) lat andLng:(double)lng{
    if (self = [super init]) {
        self.tableViewStyle = UITableViewStyleGrouped;
        NSLog(@"---->>>>  nice - got here...%f %f",lat, lng);
        self.title = @"Clique's details";
       /*self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
                                                  initWithTitle:@"Back" style:UIBarButtonItemStyleBordered
                                                  target:self action:@selector(dismiss)] autorelease];*/
        
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                                  initWithTitle:@"Next" style:UIBarButtonItemStyleBordered
                                                  target:self action:@selector(next)] autorelease];
    }
    return self;
}

- (void)dismiss {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)next {
   TTOpenURL([NSString stringWithFormat:@"tt://user/details"]);
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Clique details";
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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
