//
//  MenuController.h
//  JuicyCrumb
//
//  Created by Tom Lodge on 03/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

typedef enum {
    MenuPageNone,
    MenuPageCrumbs,
    MenuPageConfig,
    MenuPageSubscribe,
} MenuPage;

@interface MenuController : TTTableViewController {
    MenuPage _page;
}

@property(nonatomic) MenuPage page;

@end
