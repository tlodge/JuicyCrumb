//
//  MenuController.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 03/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuController.h"
#import "CrumbDataSource.h"

@implementation MenuController

@synthesize page = _page;

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

- (NSString*)nameForMenuPage:(MenuPage)page {
    switch (page) {
        case MenuPageCrumbs:
            return @"Latest Crumbs";
        case MenuPageConfig:
            return @"My Account";
        case MenuPageSubscribe:
            return @"My Cliques";
        default:
            return @"";
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithMenu:(MenuPage)page {
    if (self = [super init]) {
        self.page = page;
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        _page = MenuPageNone;
        self.variableHeightRows = YES;
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

-(void) viewDidLoad{
    [super viewDidLoad];
}


-(void) createModel{
    NSLog(@"in create model");
    
}

-(id<UITableViewDelegate>)createDelegate{
    return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}
///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController


- (void)tableView:(UITableView *)tableView didInsertRowAtIndexPath:(NSIndexPath *)newIndexPath {
    NSLog(@"stuff added....");

}


- (void)setPage:(MenuPage)page {
    _page = page;
    
    self.title = [self nameForMenuPage:page];
    
    UIImage* image = [UIImage imageNamed:@"tab.png"];
    self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
    
    self.navigationItem.rightBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"Send a Crumb" style:UIBarButtonItemStyleBordered
                                     //target:@"tt://order?waitress=Betty&ref=toolbar"
                                     target:@"tt://send?cliqueid=langbourne"
                                     //target:@"tt://nib/LoginView/LoginViewController"
                                     action:@selector(openURLFromButton:)] autorelease];
 
    
    if (_page == MenuPageCrumbs) {
       
                          
        CrumbDataSource *crumbdataSource = [[CrumbDataSource alloc] init];
        self.dataSource =  crumbdataSource;
        TT_RELEASE_SAFELY(crumbdataSource);
    } else if (_page == MenuPageConfig) {
        self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
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
                           nil];
    } else if (_page == MenuPageSubscribe) {
        self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
                           @"Appetizers",
                           [TTTableTextItem itemWithText:@"Potstickers" URL:@"tt://food/potstickers"],
                           [TTTableTextItem itemWithText:@"Egg Rolls" URL:@"tt://food/eggrolls"],
                           [TTTableTextItem itemWithText:@"Buffalo Wings" URL:@"tt://food/wings"],
                           @"Entrees",
                           [TTTableTextItem itemWithText:@"Steak" URL:@"tt://food/steak"],
                           [TTTableTextItem itemWithText:@"Chicken Marsala" URL:@"tt://food/marsala"],
                           [TTTableTextItem itemWithText:@"Cobb Salad" URL:@"tt://food/cobbsalad"],
                           [TTTableTextItem itemWithText:@"Green Salad" URL:@"tt://food/greensalad"],
                           @"Drinks",
                           [TTTableTextItem itemWithText:@"Red Wine" URL:@"tt://food/redwine"],
                           [TTTableTextItem itemWithText:@"White Wine" URL:@"tt://food/whitewhine"],
                           [TTTableTextItem itemWithText:@"Beer" URL:@"tt://food/beer"],
                           [TTTableTextItem itemWithText:@"Coke" URL:@"tt://food/coke"],
                           [TTTableTextItem itemWithText:@"Sparkling Water" URL:@"tt://food/coke"],
                           @"Other",
                           [TTTableTextItem itemWithText:@"Just Desserts" URL:@"tt://menu/4"],
                           [TTTableTextItem itemWithText:@"Complaints" URL:@"tt://about/complaints"],
                           nil];
    }
}

@end
