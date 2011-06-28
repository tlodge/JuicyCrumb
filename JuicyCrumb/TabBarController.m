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
                       @"tt://cliques",
                      @"tt://menu/2",
                     
                      /*@"tt://nib/LoginView/LoginViewController",*/
                      nil]];
}
@end
