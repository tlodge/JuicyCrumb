//
//  CrumbSendController.h
//  JuicyCrumb
//
//  Created by Tom Lodge on 27/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CrumbSendController : TTViewController <TTTabDelegate> {
    NSString* _clique;
    TTTabBar* _sendToTabBar;
    UIView *_sendToView;
}

@property(nonatomic,copy) NSString* clique;
@property(nonatomic,retain) UIView *sendToView;
@end
