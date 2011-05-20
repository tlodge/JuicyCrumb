//
//  CrumbDetailController.m
//  TTNavigatorDemo
//
//  Created by Tom Lodge on 06/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CrumbDetailController.h"
#import "ResponseDataSource.h"

@implementation CrumbDetailController

@synthesize crumbId = _crumbId;
@synthesize headerView;
@synthesize footerView;

- (id)initWithMenu:(NSString*)crumbId {
    if (self = [super init]) {
        
        //tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
        CGRect aframe = self.tableView.frame;
        aframe.origin.y += 150;
        aframe.size.height -= 150;
        self.tableView.frame = aframe;
        CGRect thebounds = TTScreenBounds();
        UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0,0,thebounds.size.width,  150)];
        
        UILabel *question = [[UILabel alloc] initWithFrame:CGRectMake(0,0,thebounds.size.width,100)];
        question.lineBreakMode = UILineBreakModeWordWrap;
        question.numberOfLines = 0;
        question.textAlignment =  UITextAlignmentCenter;
        question.backgroundColor = [UIColor clearColor];
        question.font = [UIFont boldSystemFontOfSize:20];
        question.text = [NSString stringWithFormat:@"\"%@\"", @"This is something that I need to know"];
        [myView addSubview:question];
        [question release];
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"Respond" forState:UIControlStateNormal];
        [button addTarget:@"tt://order/food" action:@selector(openURLFromButton:)
         forControlEvents:UIControlEventTouchUpInside];
        [button sizeToFit];
        button.frame = CGRectMake(20, 95, thebounds.size.width - 40, 50);
        [myView addSubview:button];
        
      
        
        
        [myView setBackgroundColor:[UIColor greenColor]];
        self.headerView = myView;
        [myView release];
        [self.view addSubview:headerView];
        self.crumbId= crumbId;
    }
    return self;
}

- (void)model:(id<TTModel>)model didInsertObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
    NSLog(@"great...in detail and model did insert object...");
}

- (void)setCrumbId:(NSString*)crid {
    _crumbId = crid;
    ResponseDataSource *mydataSource = [[ResponseDataSource alloc] initWithCrumb:_crumbId];
    self.dataSource =  mydataSource;
    TT_RELEASE_SAFELY(mydataSource);
}

- (void)viewDidUnload {
    NSLog(@"view has unloaded!!!");
   
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    NSLog(@"deallocing myself.....");
    [super dealloc];
}



@end
