//
//  CrumbDataSource.h
//  JuicyCrumb
//
//  Created by Tom Lodge on 13/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CrumbDataModel;

@interface CrumbDataSource : TTListDataSource {
    CrumbDataModel *dataModel;
    UITableView *tableView;
     NSDate *latestcrumb;
}

@property(nonatomic, retain) NSDate *latestcrumb;

@end
