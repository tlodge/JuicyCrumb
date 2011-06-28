//
//  MapOverlayView.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 24/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapOverlayView.h"


@implementation MapOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"in here..");
    return [super hitTest:point withEvent:event];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



- (void)dealloc
{
    [super dealloc];
}

@end
