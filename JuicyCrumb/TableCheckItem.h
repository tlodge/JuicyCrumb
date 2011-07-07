//
//  TableCheckItem.h
//  JuicyCrumb
//
//  Created by Tom Lodge on 07/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum CheckMarkState {
        CheckMarkNone = NO,
        CheckMarkChecked = YES
}CheckmarkState;


@interface TableCheckItem : TTTableTextItem {
    CheckmarkState state;
}

@property(nonatomic) CheckmarkState state;

+(id) itemWithText:(NSString *)text state:(CheckmarkState) s;

@end
