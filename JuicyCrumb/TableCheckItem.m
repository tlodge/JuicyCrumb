//
//  TableCheckItem.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 07/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TableCheckItem.h"


@implementation TableCheckItem
@synthesize state;

+(id) itemWithText:(NSString *)text state:(CheckmarkState) state{
    
    TableCheckItem *item = [[[self alloc] init] autorelease];
    item.text = text;
    item.state = state;
    return item;
}


@end
