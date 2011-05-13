//
//  CrumbDataModel.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 13/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CrumbDataModel.h"
#import "JSON.h"
#import "Crumb.h"

@implementation CrumbDataModel

@synthesize items;

-(id) init {
	if (self = [super init]) {
		 self.items = [[NSMutableArray alloc] init];
	}
	return self;
}


/*
 * Note that the load method is the only place where the data model will directly add
 * data to itself.  After this, it remains the responsibility of the datasource!
 */
-(void) load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more{
   
    
    done = NO;
    loading = YES;
    
     NSArray *keys = [NSArray arrayWithObjects: @"identity", @"type", @"author", @"content", @"clique", @"date", nil];
     NSArray *values = [NSArray arrayWithObjects: @"1",@"text",@"author1",@"somecontent",@"langbourne", @"2001-03-24 10:45:32", nil];
     NSDictionary* crumbdict = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
     Crumb* acrumb = [[Crumb alloc] initWithDictionary:crumbdict];
    [self.items addObject:acrumb];
    //[acrumb release];
     [crumbdict release];
     
    /* 
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:filePath];
    SBJsonParser *jsonParser = [SBJsonParser new];
    NSDictionary *data  = (NSDictionary *) [jsonParser objectWithString:content error:nil];
    if (data == nil){
        NSLog(@"DATA IS NIL>>>>");
        return;
    }
    else{
       
        NSArray *crumbs = [data objectForKey:@"crumbs"];
        for (NSDictionary* eachCrumb in  crumbs){
            Crumb *aCrumb = [[Crumb alloc] initWithDictionary:eachCrumb];
            [self.items addObject:aCrumb];
        }
       
    }
    */
    done = YES;
    loading = NO;
    [self didFinishLoad];
}

-(BOOL) isLoaded{
    return done;
}

-(BOOL) isLoading{
    return loading;
}

-(void) dealloc{
    [items release];
    [super dealloc];
}



@end
