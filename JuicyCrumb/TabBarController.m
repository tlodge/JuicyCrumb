//
//  TabBarController.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 03/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TabBarController.h"


@implementation TabBarController

- (void)viewDidLoad {
    [self setTabURLs:[NSArray arrayWithObjects:@"tt://menu/1",
                      @"tt://menu/2",
                      @"tt://menu/3",
                      @"tt://menu/4",
                      @"tt://menu/5",
                      nil]];
}
@end
