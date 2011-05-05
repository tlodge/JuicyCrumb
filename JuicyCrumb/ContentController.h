//
//  ContentController.h
//  JuicyCrumb
//
//  Created by Tom Lodge on 05/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ContentController : TTViewController {
    NSString* _content;
    NSString* _text;
}

@property(nonatomic,copy) NSString* content;
@property(nonatomic,copy) NSString* text; 
    


@end
