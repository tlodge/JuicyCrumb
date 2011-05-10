//
//  ResponseDataSource.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 10/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ResponseDataSource.h"
#import "Response.h"
#import "MyDataModel.h"

@implementation ResponseDataSource

-(id) initWithCrumb:(int) crid{
    if (self = [super init]){
        dataModel = [MyDataModel sharedModel];
        crumbid = crid;
    }
    return self;
}

-(id<TTModel>)model{
    return dataModel;
}

-(void) tableViewDidLoadModel:(UITableView *)tv{
    tableView = tv;
    [self update];
    
    NSTimer* timer;
   /* timer = [NSTimer scheduledTimerWithTimeInterval:2.0 
                                             target:self
                                           selector:@selector(addCrumb:)
                                           userInfo:nil      
                                            repeats:YES
             ];*/
    
}



-(void) update{
    NSArray *modelItems = [dataModel responsesForCrumb:crumbid];
    
    NSMutableArray *updatedItems = [NSMutableArray arrayWithCapacity:modelItems.count];
    
    for (Response* response in modelItems){
        
        TTTableTextItem *item = [TTTableTextItem itemWithText:response.content  URL:[NSString stringWithFormat:@"tt://response/%@", response.identity]];
        [updatedItems addObject:item];
    }
    
    
    self.items = updatedItems;
}


-(NSString *) titleForLoading:(BOOL)reloading{
    return @"Loading";
}

-(NSString *) titleForEmpty{
    return @"No crumbs";
}

-(NSString *) titleForError:(NSError*)error{
    return @"oops";
}

-(NSString *) subtitleForError:(NSError*)error{
    return @"oops again";
}

-(void) dealloc{
    [super dealloc];
}

@end
