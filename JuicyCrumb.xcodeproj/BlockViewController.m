//
//  BlockViewController.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 10/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BlockViewController.h"


@implementation BlockViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"The development";
        aview = [[UIView alloc] initWithFrame:CGRectMake(0,0,100,100)];
        aview.backgroundColor = [UIColor redColor];
        [self.view addSubview:aview];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UIImageView* newView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apartmentwindow.png"]];
    newView.frame = CGRectMake(0, 0, 100, 100);
    
    // UIView* newView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    newView.backgroundColor = [UIColor redColor];
   
    // [newView addSubview:;
    
    //set its alpha?? would work for fade in...
    // get the view that's currently showing
    UIView *currentView = aview;
    // get the the underlying UIWindow, or the view containing the current view view
    UIView *theWindow = [currentView superview];
    
    // remove the current view and replace with myView1
    [currentView removeFromSuperview];
    [theWindow addSubview:newView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:self];
    newView.frame = self.view.frame;
    newView.backgroundColor = [UIColor yellowColor];
    
    [UIView commitAnimations];
    // set up an animation for the transition between the views
    /*CATransition *animation = [CATransition animation];
    [animation setDuration:1.5];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[theWindow layer] addAnimation:animation forKey:@"SwitchToView1"];*/
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
