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

- (id)initWithWaitress:(NSString*)waitress query:(NSDictionary*)query {
    if (self = [super init]) {
        self.content = waitress;
        self.text = [NSString stringWithFormat:@"What do you want to say?"];
        
        self.title = @"Send a crumb";
        
        int PADDINGX = 10;
        
         TTView* aView = [[[TTView alloc] initWithFrame:CGRectMake(PADDINGX,50,self.view.frame.size.width-(2*PADDINGX),100)] autorelease];
         UIColor* black = RGBCOLOR(158, 163, 172);
        
        aView.style = [TTShapeStyle styleWithShape:[TTSpeechBubbleShape shapeWithRadius:5 pointLocation:290
                                                                             pointAngle:270
                                                                              pointSize:CGSizeMake(20,10)] next:
                       [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
                        [TTSolidBorderStyle styleWithColor:black width:1 next:nil]]];
        
        UITextView *aTextView = [[UITextView alloc] initWithFrame:CGRectMake(2,2,self.view.frame.size.width-(15 + (2*PADDINGX)) ,85)];
        aTextView.text = @"dhsasdasdsad";
      
        
        
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
                                                  initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered
                                                  target:self action:@selector(dismiss)] autorelease];
        
        
        /*
        
        NSString *kText = @"Who do you want to send it to?";
       TTStyledTextLabel* label1 = [[[TTStyledTextLabel alloc] initWithFrame:CGRectMake(PADDINGX, 200, 100,100)] autorelease];
        
        label1.font = [UIFont systemFontOfSize:17];
        label1.text = [TTStyledText textFromXHTML:kText lineBreaks:YES URLs:YES];
        label1.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
         [self.view addSubview:label1];
         [label1 release]*/
       
        
        [aView addSubview:aTextView];
        
        [self.view addSubview:aView];
       ;
        //TTDINFO(@"ORDER REFERRED FROM %@", [query objectForKey:@"ref"]);
    }
    return self;
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
