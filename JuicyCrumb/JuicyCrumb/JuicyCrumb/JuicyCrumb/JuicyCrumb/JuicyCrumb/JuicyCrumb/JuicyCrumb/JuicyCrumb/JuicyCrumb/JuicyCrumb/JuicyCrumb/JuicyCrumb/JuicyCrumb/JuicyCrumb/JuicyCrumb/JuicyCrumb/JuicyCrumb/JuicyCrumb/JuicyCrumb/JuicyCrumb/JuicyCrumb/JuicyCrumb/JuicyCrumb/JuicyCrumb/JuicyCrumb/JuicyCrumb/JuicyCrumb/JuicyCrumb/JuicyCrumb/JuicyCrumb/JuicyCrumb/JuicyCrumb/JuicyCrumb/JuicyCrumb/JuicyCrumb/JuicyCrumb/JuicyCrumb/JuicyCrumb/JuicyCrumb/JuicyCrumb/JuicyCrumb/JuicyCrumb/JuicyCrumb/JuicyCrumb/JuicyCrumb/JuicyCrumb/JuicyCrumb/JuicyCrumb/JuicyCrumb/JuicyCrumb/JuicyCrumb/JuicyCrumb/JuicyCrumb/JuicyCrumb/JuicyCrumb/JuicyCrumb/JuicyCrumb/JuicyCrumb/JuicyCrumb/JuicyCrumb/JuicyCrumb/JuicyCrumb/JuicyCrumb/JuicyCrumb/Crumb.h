//
//  Crumb.h
//  JuicyCrumb
//
//  Created by Tom Lodge on 21/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Crumb : NSObject {
    NSString* identity;
    NSString* type;
    NSString* content;
    NSString* author;
    NSString* clique;
    NSDate* date;
}

@property(nonatomic,copy) NSString* identity;
@property(nonatomic,copy) NSString* type;
@property(nonatomic,copy) NSString* content;
@property(nonatomic,copy) NSString* author;
@property(nonatomic,copy) NSString* clique;
@property(nonatomic,copy) NSDate* date;

- (id)initWithDictionary:(NSDictionary *)aDictionary;

@end
