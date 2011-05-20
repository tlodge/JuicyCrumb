//
//  ResponseDataModel.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 13/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ResponseDataModel.h"
#import "Response.h"

@implementation ResponseDataModel


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
    NSLog(@"loading in some responses....");
    
    NSArray *keys = [NSArray arrayWithObjects: @"identity", @"responseto", @"content", @"author", @"date",nil];
    NSArray *values = [NSArray arrayWithObjects: @"1", @"1",@"some response",@"someone", @"2001-03-24 10:45:32", nil];
    NSDictionary* responsedict = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    Response* aresponse = [[Response alloc] initWithDictionary:responsedict];
    [responsedict release];
    [self.items addObject:aresponse];
    done = YES;
    loading = NO;
    [self didFinishLoad];
    NSLog(@"my items size is now %d", [self.items count]);
    

}

-(BOOL) isLoaded{
    return done;
}

-(BOOL) isLoading{
    return loading;
}

-(void) dealloc{
    NSLog(@"deallocing the response data model..");
    [items release];
    [super dealloc];
}



@end
