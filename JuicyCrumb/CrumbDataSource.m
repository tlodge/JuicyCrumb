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
#import "NetworkManager.h"

@interface CrumbDataSource()
-(void) update;
@end

@implementation CrumbDataSource


@synthesize latestcrumb;

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
    NSLog(@"registering interest in new crumbs!!!");
    [[NetworkManager sharedManager] getLatestData];
   // [[NetworkManager sharedManager] refreshData];
     
     NSLog(@"successfully refreshed data!");
    tableView = tv;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newCrumbsReceived:) name:@"newCrumbsReceived" object:nil];
	[self update];
     NSLog(@"successfully updated data!");
}




/*
 * Get everything from the data model and add it to self.items
 */
-(void) update{
    NSLog(@"updating...");
    NSMutableArray *modelItems = [dataModel items];
     NSLog(@"got model items!...");
    NSMutableArray *updatedItems = [NSMutableArray arrayWithCapacity:modelItems.count];
     NSLog(@"got sise is %d", [modelItems count]);
    for (Crumb* crumb in modelItems){
        NSString *tmpURL = [NSString stringWithFormat:@"tt://detail/%@",[crumb identity]];
        TTTableTextItem *item = [TTTableTextItem itemWithText:crumb.content  URL:tmpURL];
        [updatedItems addObject:item];
        if (latestcrumb != nil){
            if ([latestcrumb earlierDate:[crumb date]])
                self.latestcrumb = [crumb date];
        }
    }
    
    NSLog(@"finished updating my current items");
    self.items = updatedItems;
}


-(void) newCrumbsReceived:(NSNotification *) notification{
    //assume ordered!
    NSLog(@"ahahaha, new crumbs received!!");
    
    NSMutableArray *latestcrumbs =  [[NetworkManager sharedManager] allCrumbsSince:self.latestcrumb];
    
    NSMutableArray *insertedIndexPaths = [[NSMutableArray alloc] init];
    
    int index = [latestcrumbs count] - 1;
    
    for (NSDictionary *dict in latestcrumbs){
        Crumb* acrumb = [[Crumb alloc] initWithDictionary:dict];
       // if ([dataModel.items count] <= 0){
               [dataModel.items addObject:acrumb];
        //}else{
          //     [dataModel.items insertObject:acrumb atIndex:index];
       // }
        [insertedIndexPaths addObject:[NSIndexPath indexPathForRow:index inSection:0]];
        index -= 1;
    }
    
    [self update];
    
    [tableView beginUpdates];
    [tableView insertRowsAtIndexPaths:insertedIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [tableView endUpdates];
    
}

-(void) addCrumb:(NSTimer *)timer{
    
    //SIMULATE GETTING SOMETHING FROM THE NETWORK MANAGER....
   // NSLog(@"would add a crumb..");
    //NSArray *keys = [NSArray arrayWithObjects: @"identity", @"type", @"author", @"content", @"clique", @"date", nil];
    //NSArray *values = [NSArray arrayWithObjects: @"1",@"text",@"author1",@"somecontent",@"langbourne", @"2001-03-24 10:45:32", nil];
    //NSDictionary* crumbdict = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    //Crumb* acrumb = [[Crumb alloc] initWithDictionary:crumbdict];
    //[crumbdict release];
    
    //if ([dataModel.items count] <= 0){
     //   [dataModel.items addObject:acrumb];
    //}else{
     //   [dataModel.items insertObject:acrumb atIndex:0];
    //}
    
   
    //[self update];
    //NSArray *insertedIndexPaths = [NSArray arrayWithObjects: [NSIndexPath indexPathForRow:0 inSection:0],nil ];
    
    
   // [tableView beginUpdates];
   // [tableView insertRowsAtIndexPaths:insertedIndexPaths withRowAnimation:UITableViewRowAnimationFade];
   // [tableView endUpdates];
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
   // [dataModel release];
    [super dealloc];
}
@end
