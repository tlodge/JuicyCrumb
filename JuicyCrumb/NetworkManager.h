//
//  NetworkManager.h
//  JuicyCrumb
//
//  Created by Tom Lodge on 16/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NetworkManager : NSObject {
    NSMutableArray* crumbs;
    NSMutableDictionary* responses;
}

@property(nonatomic, retain) NSMutableArray *crumbs;
@property(nonatomic, retain) NSMutableDictionary *responses;

+ (NetworkManager*)sharedManager;

-(NSMutableArray *) allCrumbsSince:(NSDate *) adate;

-(NSMutableArray *) responsesSince:(NSDate *) adate forCrumb:(NSString *) crumbid;

@end
