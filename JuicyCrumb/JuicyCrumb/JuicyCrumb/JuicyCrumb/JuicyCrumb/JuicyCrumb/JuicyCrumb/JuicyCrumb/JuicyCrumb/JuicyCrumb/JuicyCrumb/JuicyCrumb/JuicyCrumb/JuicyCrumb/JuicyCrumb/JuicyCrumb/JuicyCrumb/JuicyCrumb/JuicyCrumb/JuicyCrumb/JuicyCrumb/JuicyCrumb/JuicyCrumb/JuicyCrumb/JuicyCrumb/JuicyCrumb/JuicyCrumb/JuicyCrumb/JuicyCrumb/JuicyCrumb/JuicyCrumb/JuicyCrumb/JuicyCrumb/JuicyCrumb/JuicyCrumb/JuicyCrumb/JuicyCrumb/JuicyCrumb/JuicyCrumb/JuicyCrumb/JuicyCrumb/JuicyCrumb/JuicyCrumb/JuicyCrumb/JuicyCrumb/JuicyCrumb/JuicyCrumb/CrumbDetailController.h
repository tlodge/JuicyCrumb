//
//  CrumbDetailController.h
//  TTNavigatorDemo
//
//  Created by Tom Lodge on 06/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CrumbDetailController : TTTableViewController {
    NSString* _crumbId;
    UIView *headerView;
    UIView *footerView;
}

@property(nonatomic, assign) NSString* crumbId;
@property(nonatomic, retain) UIView *headerView;
@property(nonatomic, retain) UIView *footerView;

- (id)initWithMenu:(NSString*)crumbId;

@end
