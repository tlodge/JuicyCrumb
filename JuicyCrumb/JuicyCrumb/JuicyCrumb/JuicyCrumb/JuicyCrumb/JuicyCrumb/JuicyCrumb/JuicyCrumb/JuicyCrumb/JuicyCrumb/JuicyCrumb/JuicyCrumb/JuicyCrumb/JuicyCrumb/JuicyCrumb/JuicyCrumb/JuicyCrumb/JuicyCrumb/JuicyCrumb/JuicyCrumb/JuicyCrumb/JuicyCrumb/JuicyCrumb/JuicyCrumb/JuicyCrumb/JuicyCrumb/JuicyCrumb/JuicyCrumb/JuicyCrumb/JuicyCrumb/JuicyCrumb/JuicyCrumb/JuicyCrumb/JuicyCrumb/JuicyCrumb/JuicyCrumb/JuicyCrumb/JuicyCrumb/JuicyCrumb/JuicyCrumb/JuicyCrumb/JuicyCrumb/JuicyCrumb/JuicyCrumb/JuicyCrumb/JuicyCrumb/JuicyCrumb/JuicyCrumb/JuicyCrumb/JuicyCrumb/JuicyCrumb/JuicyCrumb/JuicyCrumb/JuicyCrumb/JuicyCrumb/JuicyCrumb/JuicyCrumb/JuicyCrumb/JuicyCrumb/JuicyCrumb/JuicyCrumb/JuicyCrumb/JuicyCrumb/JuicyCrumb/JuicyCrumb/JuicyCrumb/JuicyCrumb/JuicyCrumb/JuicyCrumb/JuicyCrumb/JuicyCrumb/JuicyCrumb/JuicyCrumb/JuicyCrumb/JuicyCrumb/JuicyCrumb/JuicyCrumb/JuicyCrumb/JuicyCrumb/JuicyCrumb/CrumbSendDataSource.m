//
//  CrumbSendDataSource.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 07/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CrumbSendDataSource.h"
#import "CheckmarkTableCell.h"
#import "TableCheckItem.h"

@implementation CrumbSendDataSource


-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
    if ([object isKindOfClass:[TableCheckItem class]]){
        return [CheckmarkTableCell class];
    }else{
        return [super tableView:tableView cellClassForObject:object];
    }
}


@end
