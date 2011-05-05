//
//  MyDataSource.h
//  JuicyCrumb
//
//  Created by Tom Lodge on 04/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyDataModel;

@interface MyDataSource : TTListDataSource {
    MyDataModel *dataModel;
    UITableView *tableView;
    NSMutableArray* myIndexPaths;
}

@end
