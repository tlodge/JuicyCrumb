//
//  JoinCliqueViewController.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 09/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JoinCliqueViewController.h"


@implementation JoinCliqueViewController

- (id)initWithClique:(NSString*)cliqueid{ 
    if (self = [super init]) {
        self.title = @"Join Clique";
        
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
                                                  initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered
                                                  target:self action:@selector(dismiss)] autorelease];
        
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                                   initWithTitle:@"Join!" style:UIBarButtonItemStyleDone
                                                   target:self action:@selector(join)] autorelease];
    
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

-(void) join{
    NSLog(@"would join it here....");
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
