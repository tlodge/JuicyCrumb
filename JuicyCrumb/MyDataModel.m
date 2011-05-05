//
//  MyDataModel.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 04/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyDataModel.h"
#import "JSON.h"
#import "Crumb.h"

@implementation MyDataModel
@synthesize items;


#pragma mark --
#pragma mark TTModel methods

/*-(id) init{
    if (self = [super init]){
      //NSLog(@"initing data source");
      //self.items = [[NSMutableArray alloc] init];
      //done = YES;
      //loading = NO;
      //[self didFinishLoad];
    }
    return self;
}*/

-(void) load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more{
    NSLog(@"loading data...");
    done = NO;
    loading = YES;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:filePath];
    SBJsonParser *jsonParser = [SBJsonParser new];
    NSDictionary *data  = (NSDictionary *) [jsonParser objectWithString:content error:nil];
    if (data == nil){
        NSLog(@"DATA IS NIL>>>>");
        return;
    }
    else{
        self.items = [[NSMutableArray alloc] init];
        NSArray *crumbs = [data objectForKey:@"crumbs"];
        for (NSDictionary* eachCrumb in  crumbs){
           Crumb *aCrumb = [[Crumb alloc] initWithDictionary:eachCrumb];
            NSLog(@"LOADING A a crumb....%@", aCrumb.content);
            
            [self.items addObject:aCrumb];
        }
    }
    
    done = YES;
    loading = NO;
    [self didFinishLoad];
   
}

/*
-(void) handleTimer:(NSTimer*)timer{
    
    NSArray *keys = [NSArray arrayWithObjects: @"identity", @"type", @"author", @"content", @"clique", @"date", nil];
    NSArray *values = [NSArray arrayWithObjects: @"1",@"text",@"author1",@"somecontent",@"langbourne", @"2001-03-24 10:45:32", nil];
    NSDictionary* crumbdict = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    Crumb* acrumb = [[Crumb alloc] initWithDictionary:crumbdict];
    [self.items insertObject:acrumb atIndex:0];
    
    //[self.items setObject:acrumb atIndex
    [self didFinishLoad];
}*/

-(BOOL) isLoaded{
    return done;
}

-(BOOL) isLoading{
    return loading;
}

-(void) dealloc{
    [super dealloc];
}
@end
