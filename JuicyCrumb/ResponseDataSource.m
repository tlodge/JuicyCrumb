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

#import "ResponseDataSource.h"
#import "ResponseDataModel.h"
#import "Response.h"
#import "NetworkManager.h"
#import "JSON.h"

@interface ResponseDataSource()
-(void) update;
@end

@implementation ResponseDataSource

//@synthesize tableView;
@synthesize dataModel;
@synthesize latestresponse;
@synthesize crumbid;


-(id) initWithCrumb:(NSString*)crid{
    if (self = [super init]){
        self.dataModel = [[ResponseDataModel alloc] init];
        self.crumbid = crid;
    }
    return self;
}
-(id) init{
    if (self = [super init]){
        self.dataModel = [[ResponseDataModel alloc] init];
      
    }
    return self;
}

-(id<TTModel>)model{
    return dataModel;
}

-(void) tableViewDidLoadModel:(UITableView *)tv{
    tableView = tv;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newResponsesReceived:) name:@"newResponsesReceived" object:nil];
	
    [self update];
           
}

-(void) newResponsesReceived:(NSNotification *) notification{

    NSMutableArray *latestresponses =  [[NetworkManager sharedManager] allResponsesSince:self.latestresponse forCrumb:crumbid];
    NSMutableArray *insertedIndexPaths = [[NSMutableArray alloc] init];
    
    int index = [latestresponses count] - 1;
    
    for (Response *aresponse in latestresponses){
        [dataModel.items addObject:aresponse];
        [insertedIndexPaths addObject:[NSIndexPath indexPathForRow:index inSection:0]];
        index -= 1;
    }
    
    [self update];
    
    [tableView beginUpdates];
    [tableView insertRowsAtIndexPaths:insertedIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [tableView endUpdates];
}


-(void) update{
    NSMutableArray *modelItems = [dataModel items];
    NSLog(@"there are %d model items", [modelItems count]);
    NSMutableArray *updatedItems = [NSMutableArray arrayWithCapacity:modelItems.count];
    
    for (Response* response in modelItems){
        NSString *tmpURL = [NSString stringWithFormat:@"tt://detail/%@",[response identity]];
        TTTableTextItem *item = [TTTableTextItem itemWithText:response.content  URL:tmpURL];
        [updatedItems addObject:item];
        if (latestresponse != nil){
            if ([latestresponse compare:response.date] == NSOrderedAscending) //if the latestcrumb I have is older than this, set it to the crumb date
                self.latestresponse = [response date];
        }else{
            self.latestresponse = [response date];
        }
      
    }
    
    
    self.items = updatedItems;
}


/*

-(void) addCrumb:(NSTimer *)timer{
    
    NSLog(@"would add a response...");
    //SIMULATE GETTING SOMETHING FROM THE NETWORK MANAGER....
     // [self update];
    
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
    
    NSLog(@"index set length is %d", [indexes count]);
    
    NSArray *keys = [NSArray arrayWithObjects: @"identity", @"type", @"author", @"content", @"clique", @"date", nil];
    NSArray *values = [NSArray arrayWithObjects: @"1",@"text",@"author1",@"somecontent",@"langbourne", @"2001-03-24 10:45:32", nil];
    NSDictionary* crumbdict = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    Crumb* acrumb = [[Crumb alloc] initWithDictionary:crumbdict];
    [crumbdict release];
    
    if ([dataModel.items count] <= 0){
        NSLog(@"data model count items <= 0");
        [dataModel.items addObject:acrumb];
    }else{
        NSLog(@"adding itmes at idnex 0");

        [dataModel.items insertObject:acrumb atIndex:0];
    }
    
    [dataModel didFinishLoad];
    //[self update];
    //NSArray *insertedIndexPaths = [NSArray arrayWithObjects: [NSIndexPath indexPathForRow:0 inSection:0],nil ];
    
    //NSLog(@"indrted index paths length is %d", [insertedIndexPaths count]);
    
    //Dies here when switch back to main crumb view...
   
    //    [self.tableView beginUpdates];
     //   [self.tableView insertRowsAtIndexPaths:insertedIndexPaths withRowAnimation:UITableViewRowAnimationFade];
      //  [self.tableView endUpdates];
    
}*/


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
   
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [dataModel release];
    [super dealloc];
}
@end
