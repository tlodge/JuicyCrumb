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

@synthesize page = _page;
@synthesize headerView;
@synthesize footerView;

- (id)initWithMenu:(NSString*)page {
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
        self.page = page;
    }
    return self;
}

- (void)setPage:(NSString*)page {
    NSLog(@"setting the page...");
    _page = page;
    ResponseDataSource *mydataSource = [[ResponseDataSource alloc] initWithCrumb:2];
    self.dataSource =  mydataSource;
    TT_RELEASE_SAFELY(mydataSource);
   
    /*[TTSectionedDataSource dataSourceWithObjects:
                       @"Menu",
                       [TTTableTextItem itemWithText:@"Mac & Cheese" URL:@"tt://food/macncheese"],
                       [TTTableTextItem itemWithText:@"Ham Sandwich" URL:@"tt://food/hamsam"],
                       [TTTableTextItem itemWithText:@"Salad" URL:@"tt://food/salad"],
                       @"Drinks",
                       [TTTableTextItem itemWithText:@"Coke" URL:@"tt://food/coke"],
                       [TTTableTextItem itemWithText:@"Sprite" URL:@"tt://food/sprite"],
                       @"Other",
                       [TTTableTextItem itemWithText:@"Just Desserts" URL:@"tt://menu/4"],
                       [TTTableTextItem itemWithText:@"Complaints" URL:@"tt://about/complaints"],
                       nil];*/

}

@end
