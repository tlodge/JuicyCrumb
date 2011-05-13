//
//  CrumbDataSource.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 13/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


/*
 * The crumb data source is responsible for obtaining data and updating its data model.
 */

#import "CrumbDataSource.h"
#import "CrumbDataModel.h"
#import "Crumb.h"
#import "JSON.h"

@interface CrumbDataSource()
-(void) update;
@end

@implementation CrumbDataSource

-(id) init{
    if (self = [super init]){
        dataModel = [[CrumbDataModel alloc] init];
    }
    return self;
}

-(id<TTModel>)model{
    return dataModel;
}

-(void) tableViewDidLoadModel:(UITableView *)tv{
    tableView = tv;
    [self update];
    
     /*NSTimer* timer;
     timer = [NSTimer scheduledTimerWithTimeInterval:8.0 
     target:self
     selector:@selector(addCrumb:)
     userInfo:nil      
     repeats:YES
     ];*/
     
}



-(void) update{
    NSMutableArray *modelItems = [dataModel items];
    
    NSMutableArray *updatedItems = [NSMutableArray arrayWithCapacity:modelItems.count];
    
    for (Crumb* crumb in modelItems){
        NSString *tmpURL = [NSString stringWithFormat:@"tt://detail/%@",[crumb identity]];
        TTTableTextItem *item = [TTTableTextItem itemWithText:crumb.content  URL:tmpURL];
        [updatedItems addObject:item];
    }
    
    
    self.items = updatedItems;
}


-(void) addCrumb:(NSTimer *)timer{
    
    //SIMULATE GETTING SOMETHING FROM THE NETWORK MANAGER....
    
    NSArray *keys = [NSArray arrayWithObjects: @"identity", @"type", @"author", @"content", @"clique", @"date", nil];
    NSArray *values = [NSArray arrayWithObjects: @"1",@"text",@"author1",@"somecontent",@"langbourne", @"2001-03-24 10:45:32", nil];
    NSDictionary* crumbdict = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    Crumb* acrumb = [[Crumb alloc] initWithDictionary:crumbdict];
    [crumbdict release];
    
    if ([dataModel.items count] <= 0){
        [dataModel.items addObject:acrumb];
    }else{
        [dataModel.items insertObject:acrumb atIndex:0];
    }
    
   
    [self update];
    NSArray *insertedIndexPaths = [NSArray arrayWithObjects: [NSIndexPath indexPathForRow:0 inSection:0],nil ];
    
    [tableView beginUpdates];
    [tableView insertRowsAtIndexPaths:insertedIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [tableView endUpdates];
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
    [dataModel release];
    [super dealloc];
}
@end
