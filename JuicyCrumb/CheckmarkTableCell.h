//
//  CheckmarkTableCell.h
//  JuicyCrumb
//
//  Created by Tom Lodge on 07/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableCheckItem.h"

@interface CheckmarkTableCell : TTTableTextItemCell {
    TableCheckItem *item;
}

@property(nonatomic,retain) TableCheckItem* item;
@property(nonatomic, assign) BOOL state;

@end
