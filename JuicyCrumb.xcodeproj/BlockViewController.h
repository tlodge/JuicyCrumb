//
//  BlockViewController.h
//  JuicyCrumb
//
//  Created by Tom Lodge on 10/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface BlockViewController : TTViewController <iCarouselDataSource, iCarouselDelegate>{
    //UIView *aview; 
    NSMutableArray *floors;
    iCarousel *carousel;
    iCarousel *newcarousel;
    
    UIView* selectedView;
    
    UIView* oldWall;
    UIView* currentWall;
    
    UIView *up;
    //UINavigationItem *navItem;
}

//@property (nonatomic, retain)  iCarousel *carousel;

//@property (nonatomic, retain)  UINavigationItem *navItem;

@end
