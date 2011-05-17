//
//  NetworkManager.h
//  JuicyCrumb
//
//  Created by Tom Lodge on 16/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NetworkManager : NSObject {
    NSMutableArray* scrumbs;
    NSMutableDictionary* responses;
    NSTimer* timer;
    NSDateFormatter* df;
}

@property(nonatomic, retain) NSMutableArray *scrumbs;
@property(nonatomic, retain) NSMutableDictionary *responses;
@property(nonatomic, retain) NSTimer *timer;
@property(nonatomic, retain) NSDateFormatter* df;

+ (NetworkManager*)sharedManager;

-(NSMutableArray *) allCrumbsSince:(NSDate *) adate;
-(NSMutableArray *) responsesSince:(NSDate *) adate forCrumb:(NSString *) crumbid;
-(void) refreshData;
-(void) getLatestData;

@end
