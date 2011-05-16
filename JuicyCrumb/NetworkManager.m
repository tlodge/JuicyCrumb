//
//  NetworkManager.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 16/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NetworkManager.h"
#import "JSON.h"

@interface NetworkManager()
-(void) refreshData:(NSTimer *)timer;
-(void) getLatestData;
@end



@implementation NetworkManager

@synthesize crumbs;
@synthesize responses;

static NetworkManager *sharedManagerInstance = nil;
static NSDateFormatter *df;

+ (NetworkManager*)sharedManager {
    @synchronized(self) {
        if (sharedManagerInstance == nil) {
            [[self alloc] init]; // assignment not done here
        }
    }
    return sharedManagerInstance;
	// note: Xcode (3.2) static analyzer will report this singleton as a false positive
	// '(Potential leak of an object allocated')
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedManagerInstance == nil) {
            sharedManagerInstance = [super allocWithZone:zone];
            return sharedManagerInstance;  // assignment and return on first allocation
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
        
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd-MM-yy HH:mm:ss"];
       
        
        NSTimer* timer;
        
        [self getLatestData];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:2.0 
                                                 target:self
                                               selector:@selector(refreshData:)
                                               userInfo:nil      
                                                repeats:YES
                 ];
	}
	return self;
}

-(void) getLatestData  {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:filePath];
    SBJsonParser *jsonParser = [SBJsonParser new];
    NSDictionary *data  = (NSDictionary *) [jsonParser objectWithString:content error:nil];
    if (data == nil){
        NSLog(@"DATA IS NIL>>>>");
        return;
    }
    else{
        
        NSMutableArray *tmpcrumbs = [data objectForKey:@"crumbs"];
        self.crumbs = tmpcrumbs;
        [tmpcrumbs release];
        
        NSMutableDictionary* tmpresponses = [data objectForKey:@"responses"];
        self.responses = tmpresponses;
        [tmpresponses release];
    }

}

-(void) refreshData: (NSTimer *)timer{
    
    NSArray *keys = [NSArray arrayWithObjects: @"identity", @"type", @"author", @"content", @"clique", @"date", nil];
    NSArray *values = [NSArray arrayWithObjects: @"1",@"text",@"author1",@"somecontent",@"langbourne", @"2001-03-24 10:45:32", nil];
    NSDictionary* crumbdict = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    [self.crumbs addObject:crumbdict];
    [crumbdict release];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newCrumbsReceived" object:nil userInfo:crumbdict];

    NSString* responseto = [NSString stringWithFormat:@"1"];
    keys = [NSArray arrayWithObjects: @"identity", @"responseto", @"content", @"author", @"date",nil];
    values = [NSArray arrayWithObjects: @"1", responseto ,@"some response",@"someone", @"2001-03-24 10:45:32", nil];
    NSDictionary* responsedict = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    
    NSMutableArray * tmpresponses = (NSMutableArray *) [responses objectForKey:responseto];
    
    if (tmpresponses == NULL){
        tmpresponses = [[NSMutableArray alloc] init];
        [tmpresponses addObject:responsedict];
    }
    else{
        [tmpresponses insertObject: responsedict atIndex:0];
    }
    
    [responses setObject:tmpresponses forKey:responseto]; 
    
    [responsedict release];
    [tmpresponses release];
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"newResponseReceived" object:nil userInfo:nil];
    //send response update notification!

}

//just do basic stuff for now

-(NSMutableArray *) allCrumbsSince:(NSDate *) adate{
    if (adate == nil){
        return crumbs;
    }else{
        NSMutableArray *toreturn = [[NSMutableArray alloc] init];
        for (NSDictionary *acrumb in crumbs){
            NSDate *crumbdate = [df dateFromString:[acrumb valueForKey:@"date"]];
            if ([adate earlierDate:crumbdate])
                [toreturn addObject:acrumb];
        }
        return toreturn;
    }
}

//just do basic stuff for now

-(NSMutableArray *) responsesSince:(NSDate *) adate forCrumb:(NSString *) crumbid{
    if (adate == nil){
        return [responses objectForKey: crumbid];
    }else{
        NSMutableArray *toreturn = [[NSMutableArray alloc] init];
        for (NSDictionary *aresponse in [responses objectForKey:crumbid]){
            NSDate *responsedate = [df dateFromString:[aresponse valueForKey:@"date"]];
            if ([adate earlierDate:responsedate])
                [toreturn addObject:aresponse];
        }
        return toreturn;
    }
}



@end
