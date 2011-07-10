//
//  Crumb.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 21/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Crumb.h"


@implementation Crumb
@synthesize identity;
@synthesize type;
@synthesize content;
@synthesize author;
@synthesize clique;
@synthesize date;


- (id)initWithDictionary:(NSDictionary *)aDictionary{
    if ([self init]) {
        self.identity = [aDictionary valueForKey:@"identity"];
        self.type     = [aDictionary valueForKey:@"type"];
		self.content  = [aDictionary valueForKey:@"content"];
        self.author   = [aDictionary valueForKey:@"author"];
        self.clique   = [aDictionary valueForKey:@"clique"];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd-MM-yy HH:mm:ss"];
        self.date = [df dateFromString:[aDictionary valueForKey:@"date"]];
        [df release];
    }
    return self;
}

- (void)dealloc {
    [identity release];
    [type release];
    [content release];
    [author release];
    [clique release];
    [date release];
    [super dealloc];
}

@end
