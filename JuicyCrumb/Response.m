//
//  Response.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 27/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Response.h"


@implementation Response
@synthesize identity;
@synthesize responseto;
@synthesize content;
@synthesize author;
@synthesize date;


- (id)initWithDictionary:(NSDictionary *)aDictionary{
    
    if ([self init]) {
        self.identity = [aDictionary valueForKey:@"identity"];
        self.responseto    = [aDictionary valueForKey:@"responseto"];
		self.content  = [aDictionary valueForKey:@"content"];
        self.author   = [aDictionary valueForKey:@"author"];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd-MM-yy HH:mm:ss"];
        self.date = [df dateFromString:[aDictionary valueForKey:@"date"]];
        [df release];
    }
    
    return self;
}

- (void)dealloc {
    [identity release];
    [responseto release];
    [content release];
    [author release];
    [date release];
    [super dealloc];
}


@end
