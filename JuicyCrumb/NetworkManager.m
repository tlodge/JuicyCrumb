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
//-(void) refreshData:(NSTimer *)timer;
//-(void) getLatestData;
@end



@implementation NetworkManager

@synthesize scrumbs;
@synthesize responses;
@synthesize timer;
@synthesize df;

static NetworkManager *sharedManagerInstance = nil;

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
        NSLog(@"initing the network manager...");
        self.df = [[NSDateFormatter alloc] init];
        [self.df setDateFormat:@"dd-MM-yy HH:mm:ss"];
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
        self.scrumbs = [[NSMutableArray alloc] init];
        
        NSMutableArray *tmpcrumbs = (NSMutableArray*) [data objectForKey:@"crumbs"];
        for (NSDictionary *dict in tmpcrumbs){
            NSLog (@"got a crumb %@", [dict objectForKey:@"content"]);
            [self.scrumbs addObject:dict];
        }
        
        NSLog(@"the crumbs size is %d", [scrumbs count]);
       self.scrumbs = tmpcrumbs;
        //[tmpcrumbs release];
        
        //NSMutableDictionary* tmpresponses = (NSMutableDictionary*) [data objectForKey:@"responses"];
        //self.responses = tmpresponses;
        //[tmpresponses release];
    }
   
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 
                                                  target:self
                                                selector:@selector(refreshData:)
                                                userInfo:nil      
                                                 repeats:YES
                  ];

  
}

-(void) refreshData: (NSTimer*) timer{
    NSLog(@"refreshing data!!!");
    
    NSArray *keys = [NSArray arrayWithObjects: @"identity", @"type", @"author", @"content", @"clique", @"date", nil];
    NSArray *values = [NSArray arrayWithObjects: @"1",@"text",@"author1",@"somecontent",@"langbourne", @"2001-03-24 10:45:32", nil];
    
    NSLog(@"the crumbs size is %d", [self.scrumbs count]);
    
    NSDictionary* crumbdict = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    
    NSLog(@"adding a crumb to crumb array size %d", [self.scrumbs count]);
    [scrumbs addObject:crumbdict];
    [crumbdict release];
     
     
   // NSLog(@"posting notification!");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newCrumbsReceived" object:nil userInfo:crumbdict];

    /*
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
     */
}

//just do basic stuff for now

-(NSMutableArray *) allCrumbsSince:(NSDate *) adate{
    
    
    if (adate == nil){
        return self.scrumbs;
    }else{
        NSMutableArray *toreturn = [[NSMutableArray alloc] init];
        for (NSDictionary *acrumb in scrumbs){
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
