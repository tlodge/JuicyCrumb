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
#import "Crumb.h"
#import "JSON.h"

@interface ResponseDataSource()
-(void) update;
@end

@implementation ResponseDataSource

//@synthesize tableView;
@synthesize dataModel;

-(id) init{
    if (self = [super init]){
        self.dataModel = [[ResponseDataModel alloc] init];
        NSLog(@"starting a new timer thread!!!!");
    }
    return self;
}

-(id<TTModel>)model{
    return dataModel;
}

-(void) tableViewDidLoadModel:(UITableView *)tv{
    tableView = tv;
    [self update];
           
}

-(void) newDataReceived:(NSNotification *) notification{
    NSMutableArray *
}

-(void) update{
    NSMutableArray *modelItems = [dataModel items];
    NSLog(@"there are %d model items", [modelItems count]);
    NSMutableArray *updatedItems = [NSMutableArray arrayWithCapacity:modelItems.count];
    
    for (Crumb* crumb in modelItems){
        NSString *tmpURL = [NSString stringWithFormat:@"tt://detail/%@",[crumb identity]];
        TTTableTextItem *item = [TTTableTextItem itemWithText:crumb.content  URL:tmpURL];
        [updatedItems addObject:item];
        
      
    }
    
    
    self.items = updatedItems;
}


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
    NSLog(@"deallocing data model");
    [dataModel release];
    [super dealloc];
}
@end
