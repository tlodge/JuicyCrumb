//
//  NetworkManager.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 16/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NetworkManager.h"
#import "JSON.h"
#import "Crumb.h"
#import "Response.h"

@interface NetworkManager()
-(void) refreshData:(NSTimer *)timer;
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
        self.responses = [[NSMutableDictionary alloc] init];
        
        NSMutableArray *tmpcrumbs = (NSMutableArray*) [data objectForKey:@"crumbs"];
        for (NSDictionary *dict in tmpcrumbs){
            NSLog (@"got a crumb %@ date, %@", [dict objectForKey:@"content"], [dict objectForKey:@"date"]);
            [self.scrumbs addObject: [[Crumb alloc] initWithDictionary:dict]];
        }
        
        
        NSLog(@"the crumbs size is %d", [scrumbs count]);
        
        
        NSMutableArray *tmpcliques = (NSMutableArray*) [data objectForKey:@"cliques"];
        for (NSDictionary *dict in tmpcliques){
            NSLog (@"got a cliques %@", [dict objectForKey:@"identity"]);
           
        }
       //self.scrumbs = tmpcrumbs;
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
   
    NSDate *now = [[NSDate alloc] init];
    NSString *dateString = [df stringFromDate:now];
    [now release];
    NSArray *keys = [NSArray arrayWithObjects: @"identity", @"type", @"author", @"content", @"clique", @"date", nil];
    NSArray *values = [NSArray arrayWithObjects: @"1",@"text",@"author1",@"somecontent",@"langbourne", dateString, nil];
    NSDictionary* crumbdict = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    [scrumbs addObject: [[Crumb alloc] initWithDictionary:crumbdict]];
    [crumbdict release];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newCrumbsReceived" object:nil userInfo:nil];

    
    NSString* responseto = [NSString stringWithFormat:@"1"];
    
    keys = [NSArray arrayWithObjects: @"identity", @"responseto", @"content", @"author", @"date",nil];
    values = [NSArray arrayWithObjects: @"1", responseto ,@"some response",@"someone", dateString, nil];
    
    NSDictionary* responsedict = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    
    NSMutableArray * tmpresponses = (NSMutableArray *) [responses objectForKey:responseto];
    
    if (tmpresponses == NULL){
        tmpresponses = [[NSMutableArray alloc] init];
        [tmpresponses addObject: [[Response alloc] initWithDictionary:responsedict]];
    }
    else{
        [tmpresponses insertObject: [[Response alloc] initWithDictionary:responsedict] atIndex:0];
    }
    
    NSLog(@"created tmp responses of size %d", [tmpresponses count]);
    
    [responses setObject:tmpresponses forKey:responseto]; 
    
    NSLog(@"added tmpresponses to resppnses for key %@", responseto);
    
    [responsedict release];
    //[tmpresponses release];
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"newResponsesReceived" object:nil userInfo:nil];
  
}

//just do basic stuff for now

-(NSMutableArray *) allCrumbsSince:(NSDate *) adate{
    
    NSLog(@"getting all crumbs since %@", [df stringFromDate:adate]);
    if (adate == nil){
        return self.scrumbs;
    }else{
        NSMutableArray *toreturn = [[NSMutableArray alloc] init];
        
        for (Crumb *acrumb in scrumbs){
            //NSDate *crumbdate = [df dateFromString:[acrumb valueForKey:@"date"]];
            if ([adate compare:acrumb.date ] == NSOrderedAscending){
                [toreturn addObject:acrumb];
                
            }
        }
        return toreturn;
    }
}

//just do basic stuff for now

-(NSMutableArray *) allResponsesSince:(NSDate *) adate forCrumb:(NSString *) crumbid{
    
     NSLog(@"getting all responses to crumb %@ since %@", crumbid, [df stringFromDate:adate]);
    
    NSArray *myresponses = [responses objectForKey:crumbid];
    
    if (myresponses != nil){
        NSLog(@"there are %d responses for crumb %@", [myresponses count], crumbid);
    }else{
        NSLog(@"hmmm responses is nil!");
    }
    
    
    if (adate == nil){
        return [responses objectForKey: crumbid];
    }else{
        NSMutableArray *toreturn = [[NSMutableArray alloc] init];
        for (Response *aresponse in [responses objectForKey:crumbid]){
            NSLog(@"checking %@ %@", aresponse.content, aresponse.date);
           
            if ([adate compare:aresponse.date ] == NSOrderedAscending)
                [toreturn addObject:aresponse];
        }
        return toreturn;
    }
}



@end
