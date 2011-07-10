//
//  CheckmarkTableCell.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 07/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckmarkTableCell.h"


@implementation CheckmarkTableCell

@synthesize item;

@dynamic state;


-(void) setObject:(id)object{
    
    
    if (_item != object) {
        [super setObject:object];
        self.item = object;
        
        if ([self.item state])
            self.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            self.accessoryType = UITableViewCellAccessoryNone;
    }
   
}


-(void) setState:(BOOL)state{
    self.item.state = state;
    
    
    if (state){
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}
@end
