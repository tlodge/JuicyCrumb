//
//  LoginViewController.m
//  BlockPush
//
//  Created by Tom Lodge on 12/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"


@implementation LoginViewController

@synthesize cliqueName;
@synthesize userName;
@synthesize password;
@synthesize cliqueTextField;
@synthesize nameTextField;
@synthesize passwordTextField;
@synthesize delegate;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        self.title = @"Cliques";
    }
    return self;
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

-(BOOL) textFieldShouldReturn:(UITextField *)theTextField{
	[theTextField resignFirstResponder];
	return YES;
}


-(IBAction) login:(id)sender{
    [self.delegate loginViewControllerDidLogin:self user:nameTextField.text password:passwordTextField.text];
}

-(IBAction) cancel:(id)sender{
    [self.delegate loginViewControllerDidCancel:self];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
