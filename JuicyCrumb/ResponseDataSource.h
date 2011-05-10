//
//  ResponseDataSource.h
//  JuicyCrumb
//
//  Created by Tom Lodge on 10/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyDataModel;

@interface ResponseDataSource : TTListDataSource {
    MyDataModel *dataModel;    
    UITableView *tableView;
    int crumbid;
}

-(id) initWithCrumb:(int) crumbid;

@end
