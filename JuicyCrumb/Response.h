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

@property(nonatomic,assign) NSString* identity;
@property(nonatomic,assign) NSString* responseto;
@property(nonatomic,assign) NSString* content;
@property(nonatomic,assign) NSString* author;
@property(nonatomic,assign) NSDate* date;
@end
