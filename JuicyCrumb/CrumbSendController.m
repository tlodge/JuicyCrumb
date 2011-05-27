//
//  CrumbSendController.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 27/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CrumbSendController.h"
#import "CrumbSendCliqueController.h"
#import "CrumbSendAllController.h"
#import "ButtonStyleSheet.h"

@implementation CrumbSendController

@synthesize clique = _clique;
@synthesize sendToView = _sendToView;

- (id)init {
    if (self = [super init]) {
       
        _clique = nil;
        [TTStyleSheet setGlobalStyleSheet:[[[ButtonStyleSheet alloc] init] autorelease]];
       
    }
    return self;
}

- (id)initWithClique:(NSString*)cliqueid{
    if (self = [super init]) {
        UIColor* backgroundcolor = RGBCOLOR(158, 163, 172);
        [self.view setBackgroundColor:backgroundcolor];
        self.title = @"Send a crumb";
        
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
                                                  initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered
                                                  target:self action:@selector(dismiss)] autorelease];
        
        int PADDINGX = 10;
        
        CGRect frame = CGRectMake(PADDINGX, 10, self.view.width-20, 50);
        TTStyledTextLabel* what = [[[TTStyledTextLabel alloc] initWithFrame:frame] autorelease];
        what.tag = 42;
        what.font = [UIFont systemFontOfSize:22];
        [what setBackgroundColor:[UIColor clearColor]];
        
        what.html = @"What do you want to say?";
        [self.view addSubview:what];

        
        
        
        TTView* aView = [[[TTView alloc] initWithFrame:CGRectMake(PADDINGX,40,self.view.frame.size.width-(2*PADDINGX),100)] autorelease];
        
        [aView setBackgroundColor:[UIColor clearColor]];
        
        aView.style = [TTShapeStyle styleWithShape:[TTSpeechBubbleShape shapeWithRadius:5 pointLocation:60
                                                                             pointAngle:90
                                                                              pointSize:CGSizeMake(20,10)] next:
                       [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
                        [TTSolidBorderStyle styleWithColor:[UIColor whiteColor] width:1 next:nil]]];
        
        UITextView *aTextView = [[UITextView alloc] initWithFrame:CGRectMake(2,12,self.view.frame.size.width-(15 + (PADDINGX)), 85)];
        aTextView.text = @"";
        
        [aView addSubview:aTextView];
        [self.view addSubview:aView];
        
        
        frame = CGRectMake(PADDINGX, 155, self.view.width-20, 50);
        TTStyledTextLabel* whoto = [[[TTStyledTextLabel alloc] initWithFrame:frame] autorelease];
        whoto.tag = 42;
        whoto.font = [UIFont systemFontOfSize:22];
        whoto.html = @"Who do you want to say it to?";
        [whoto setBackgroundColor:[UIColor clearColor]];
        
        [self.view addSubview:whoto];
        
        
        _sendToTabBar = [[TTTabBar alloc] initWithFrame:CGRectMake(PADDINGX, 185, self.view.frame.size.width - (2 * PADDINGX), 40)];
        
        _sendToTabBar.tabItems = [NSArray arrayWithObjects:
                             [[[TTTabItem alloc] initWithTitle:@"Langbourne Place"] autorelease],
                             [[[TTTabItem alloc] initWithTitle:@"Neighbours"] autorelease],
                             nil];
        
        _sendToTabBar.selectedTabIndex = 0;
        _sendToTabBar.delegate = self;
        
        [self.view addSubview:_sendToTabBar];
        
        /*TTTabItem* item = [_sendToTabBar.tabItems objectAtIndex:0];
        item.badgeNumber = 2;
        item = [_sendToTabBar.tabItems objectAtIndex:1];
        item.badgeNumber = 30;*/

        
        self.sendToView = [[UIView alloc] initWithFrame:CGRectMake(PADDINGX, 225, self.view.frame.size.width - (2*PADDINGX), 100)];
        [self.sendToView setBackgroundColor:[UIColor greenColor]];
        [self.view addSubview: _sendToView];
        
        TTButton *sendButton = [TTButton buttonWithStyle:@"embossedButton:" title:@"Say it!"];
       
       
       
         [sendButton sizeToFit];
         sendButton.center = CGPointMake(self.view.size.width/2,self.view.size.height - 50);
        [self.view addSubview: sendButton];

    }
    return self;
}

-(void)tabBar:(TTTabBar*)tabBar tabSelected:(NSInteger) selectedIndex{
    NSLog(@"great a tab has been selected!!");
    if (selectedIndex == 1){
        
        CGRect frame  = _sendToView.frame;
        
        [_sendToView removeFromSuperview];
        [_sendToView release];
        CrumbSendCliqueController* sc = [[CrumbSendCliqueController alloc] init];
        sc.view.frame = frame;
        self.sendToView = sc.view;
        [self.view addSubview: _sendToView];
        //TTOpenURLFromView(@"tt://send/clique", _sendToView); 
    }else{
        CGRect frame  = _sendToView.frame;
        [_sendToView removeFromSuperview];
        [_sendToView release];
        CrumbSendCliqueController* sc = [[CrumbSendAllController alloc] init];
        sc.view.frame = frame;
        self.sendToView = sc.view;
        [self.view addSubview: _sendToView];
    }
}
- (void)dismiss {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_clique);
    TT_RELEASE_SAFELY(_sendToTabBar);
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    _clique = nil;
    [TTStyleSheet setGlobalStyleSheet:[[[ButtonStyleSheet alloc] init] autorelease]];
}


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
