//
//  UserDetailsViewController.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 04/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserDetailsViewController.h"


@implementation UserDetailsViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTModelViewController

- (void)createModel {
    
    UITextField* name = [[[UITextField alloc] init] autorelease];
    name.placeholder = @"Your name";
    name.font = TTSTYLEVAR(font);
    
    UITextField* email = [[[UITextField alloc] init] autorelease];
    email.placeholder = @"Your email address";
    email.font = TTSTYLEVAR(font);
    
    UITextField* apartmentnumber = [[[UITextField alloc] init] autorelease];
    apartmentnumber.placeholder = @"Your apartment number";
    apartmentnumber.font = TTSTYLEVAR(font);

    UITextField* floornumber = [[[UITextField alloc] init] autorelease];
    floornumber.placeholder = @"Your floor number";
    floornumber.font = TTSTYLEVAR(font);
    
    self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
                       @"About you",
                       name,
                       email,
                       
                       @"About your apartment",
                       apartmentnumber,
                       floornumber,
                       [TTTableTextItem itemWithText:@"Your neighbours" URL:@"tt://clique/create/structure/blocks"],
                       
                       
                      
                       nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.tableViewStyle = UITableViewStyleGrouped;
        self.autoresizesForKeyboard = YES;
        self.variableHeightRows = YES;
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
