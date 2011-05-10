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
#import "Response.h"

@implementation MyDataModel
@synthesize items;
@synthesize responsesDictionary;

#pragma mark --
#pragma mark TTModel methods

static MyDataModel *sharedModelInstance = nil;

+ (MyDataModel*)sharedModel {
    @synchronized(self) {
        if (sharedModelInstance == nil) {
            [[self alloc] init]; // assignment not done here
        }
    }
    return sharedModelInstance;
	// note: Xcode (3.2) static analyzer will report this singleton as a false positive
	// '(Potential leak of an object allocated')
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedModelInstance == nil) {
            sharedModelInstance = [super allocWithZone:zone];
            return sharedModelInstance;  // assignment and return on first allocation
        }
    }
    return nil; //on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;  //denotes an object that cannot be released
}

- (void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}

- init {
	if (self = [super init]) {
		
	}
	return self;
}

-(NSArray*) responsesForCrumb:(int) crumbid{
    NSString *key = [NSString stringWithFormat:@"%d", crumbid];
    NSArray *responsedicts = [responsesDictionary objectForKey:key];
    
    //sort this retain -- memory leak...
    
    NSMutableArray *responses = [[[NSMutableArray alloc] init] retain];
    
    for (NSDictionary* eachResponse in responsedicts){
        [responses addObject:[[Response alloc] initWithDictionary:eachResponse]];
    }
    return responses;
}

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
         self.responsesDictionary = [data objectForKey:@"responses"];
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
