//
//  MyDataModel.h
//  JuicyCrumb
//
//  Created by Tom Lodge on 04/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyDataModel : TTModel {
    NSMutableArray* items;
    BOOL done;
    BOOL loading;
}

@property(nonatomic, retain)  NSMutableArray*  items;
@end
