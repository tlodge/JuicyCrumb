//
//  Clique.h
//  JuicyCrumb
//
//  Created by Tom Lodge on 24/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Clique : NSObject {
    NSString* identity;
    NSString* name;
    NSString* tagline;
    NSString* membershiptype;
    double lng;
    double lat;
}

@property(nonatomic, copy) NSString *identity;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *tagline;
@property(nonatomic, copy) NSString* membershiptype;
@property(nonatomic, assign) double lat;
@property(nonatomic, assign) double lng;

- (id)initWithDictionary:(NSDictionary *)aDictionary;

@end
