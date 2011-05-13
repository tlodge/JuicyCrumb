//
//  Response.h
//  JuicyCrumb
//
//  Created by Tom Lodge on 27/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Response : NSObject {
    NSString* identity;
    NSString* responseto;
    NSString* content;
    NSString* author;
    NSDate* date;
}

@property(nonatomic,copy) NSString* identity;
@property(nonatomic,copy) NSString* responseto;
@property(nonatomic,copy) NSString* content;
@property(nonatomic,copy) NSString* author;
@property(nonatomic,copy) NSDate* date;

- (id)initWithDictionary:(NSDictionary *)aDictionary;

@end
