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
@synthesize crumbid;
-(id) initWithCrumb:(NSString*) crid{
    if (self = [super init]){
        dataModel = [MyDataModel sharedModel];
        self.crumbid = crid;
    }
    return self;
}

-(id<TTModel>)model{
    return dataModel;
}

-(void) tableViewDidLoadModel:(UITableView *)tv{
    tableView = tv;
    [self update];
    
   /* NSTimer* timer;
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0 
                                             target:self
                                           selector:@selector(addResponse:)
                                           userInfo:nil      
                                            repeats:YES
    ];*/
    
}


-(void) addResponse:(NSTimer*)timer{
    
    NSArray *keys = [NSArray arrayWithObjects: @"identity", @"responseto", @"content", @"author", @"date",nil];
    NSArray *values = [NSArray arrayWithObjects: @"1", self.crumbid,@"some response",@"someone", @"2001-03-24 10:45:32", nil];
    NSDictionary* responsedict = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    Response* aresponse = [[Response alloc] initWithDictionary:responsedict];
    [responsedict release];
    
    //[dataModel.items insertObject:aresponse atIndex:0];
    
    //[self update];
    
    //NSArray *insertedIndexPaths = [NSArray arrayWithObjects: [NSIndexPath indexPathForRow:0 inSection:0],nil ];
    
    //[tableView beginUpdates];
    //[tableView insertRowsAtIndexPaths:insertedIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    //[tableView endUpdates];

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
    return @"No responses";
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
