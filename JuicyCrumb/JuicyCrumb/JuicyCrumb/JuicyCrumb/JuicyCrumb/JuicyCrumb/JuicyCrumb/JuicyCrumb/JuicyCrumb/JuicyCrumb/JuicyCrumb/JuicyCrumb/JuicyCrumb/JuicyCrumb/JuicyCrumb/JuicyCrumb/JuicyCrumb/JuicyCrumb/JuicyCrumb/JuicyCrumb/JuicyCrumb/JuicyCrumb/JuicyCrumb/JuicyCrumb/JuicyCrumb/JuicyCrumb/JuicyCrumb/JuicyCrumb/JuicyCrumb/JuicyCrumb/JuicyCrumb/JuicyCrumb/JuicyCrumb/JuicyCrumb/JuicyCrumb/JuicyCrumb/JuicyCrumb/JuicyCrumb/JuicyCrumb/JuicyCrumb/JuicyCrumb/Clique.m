//
//  Clique.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 24/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Clique.h"


@implementation Clique


@synthesize identity;
@synthesize name;
@synthesize tagline;
@synthesize lat, lng;
@synthesize membershiptype;

- (id)initWithDictionary:(NSDictionary *)aDictionary{
    if ([self init]) {
        self.identity = [aDictionary valueForKey:@"identity"];
        self.name = [aDictionary valueForKey:@"name"];
        self.tagline = [aDictionary valueForKey:@"tagline"];
        NSDictionary *coordict = [aDictionary valueForKey:@"coordinates"];
        
        
        NSNumber* latitude  = [coordict valueForKey:@"lat"];
        NSNumber* longitude = [coordict valueForKey:@"lng"];
        self.lat = [latitude doubleValue];
        self.lng = [longitude doubleValue];
        self.membershiptype = [aDictionary valueForKey:@"membershiptype"];
    }
    return self;
}

- (void)dealloc {
    [identity release];
    [name release];
    [tagline release];
    [membershiptype release];
    [super dealloc];
}


@end
