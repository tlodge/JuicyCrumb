//
//  ContentController.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 05/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ContentController.h"


@implementation ContentController
@synthesize content = _content, text = _text;

- (void)dismiss {
    [self dismissModalViewControllerAnimated:YES];
}

- (id)initWithResponse:(NSString*)responseid {
    if (self = [super init]) {
        self.content = responseid;
        self.text = [NSString stringWithFormat:@"<b>%@</b> This is the response!", responseid];
        
        self.title = responseid;
        self.navigationItem.rightBarButtonItem =
        [[[UIBarButtonItem alloc] initWithTitle:@"Response" style:UIBarButtonItemStyleBordered
                                         target:self action:@selector(showMore)] autorelease];
    }
    return self;

}

-(void) showMore{
    TTOpenURL([NSString stringWithFormat:@"tt://food/%@/nutrition", self.content]);
}


- (id)init {
    if (self = [super init]) {
       
        _content = nil;
        _text = nil;
    }
    return self;
}

- (void)dealloc {
    TT_RELEASE_SAFELY(_content);
    TT_RELEASE_SAFELY(_text);
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

- (void)loadView {
    [super loadView];
    
    CGRect frame = CGRectMake(10, 10, self.view.width-20, 100);
    TTStyledTextLabel* label = [[[TTStyledTextLabel alloc] initWithFrame:frame] autorelease];
    label.tag = 42;
    label.font = [UIFont systemFontOfSize:22];
    [self.view addSubview:label];
    
   // if (_contentType == ContentTypeNutrition) {
        self.view.backgroundColor = [UIColor grayColor];
        label.backgroundColor = self.view.backgroundColor;
        self.hidesBottomBarWhenPushed = YES;
    //}
}

- (void)viewWillAppear:(BOOL)animated {
    TTStyledTextLabel* label = (TTStyledTextLabel*)[self.view viewWithTag:42];
    label.html = _text;
}



@end
