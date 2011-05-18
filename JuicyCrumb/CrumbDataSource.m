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
    [[NetworkManager sharedManager] getLatestData];
    tableView = tv;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newCrumbsReceived:) name:@"newCrumbsReceived" object:nil];
	[self update];
}




/*
 * Get everything from the data model and add it to self.items
 */
-(void) update{

    NSMutableArray *modelItems = [dataModel items];
   
    NSMutableArray *updatedItems = [NSMutableArray arrayWithCapacity:modelItems.count];
    for (Crumb* crumb in modelItems){
        NSString *tmpURL = [NSString stringWithFormat:@"tt://detail/%@",crumb.identity];
        TTTableTextItem *item = [TTTableTextItem itemWithText:crumb.content  URL:tmpURL];
        [updatedItems addObject:item];
        
        if (latestcrumb != nil){
            if ([latestcrumb compare:crumb.date] == NSOrderedAscending) //if the latestcrumb I have is older than this, set it to the crumb date
                self.latestcrumb = [crumb date];
        }else{
             self.latestcrumb = [crumb date];
        }
    }
    self.items = updatedItems;
}


-(void) newCrumbsReceived:(NSNotification *) notification{
   
    
    NSMutableArray *latestcrumbs =  [[NetworkManager sharedManager] allCrumbsSince:self.latestcrumb];
    NSMutableArray *insertedIndexPaths = [[NSMutableArray alloc] init];
    
    int index = [latestcrumbs count] - 1;
    
    for (Crumb *acrumb in latestcrumbs){
        [dataModel.items addObject:acrumb];
        [insertedIndexPaths addObject:[NSIndexPath indexPathForRow:index inSection:0]];
        index -= 1;
    }
    
    [self update];
    
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
   // [dataModel release];
    [super dealloc];
}
@end
