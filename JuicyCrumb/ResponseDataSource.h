//
//  ResponseDataSource.h
//  JuicyCrumb
//
//  Created by Tom Lodge on 10/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ResponseDataModel;


@interface ResponseDataSource : TTListDataSource {
    ResponseDataModel *dataModel;    
    UITableView *tableView;
    NSString *crumbid;
}

-(id) initWithCrumb:(NSString*) crumbid;
@property(nonatomic, retain) NSString* crumbid;
 
@end
