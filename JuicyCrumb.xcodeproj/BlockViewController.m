//
//  BlockViewController.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 10/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BlockViewController.h"
#import "ApartmentWindow.h"

#define NUMBER_OF_ITEMS 20
#define ITEM_SPACING 210
#define USE_BUTTONS YES
#define APARTMENT_SIZE 200

@interface BlockViewController () <UIActionSheetDelegate>

@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, retain) NSMutableArray *items;

@end


@implementation BlockViewController

@synthesize carousel;
//@synthesize navItem;
@synthesize wrap;
@synthesize items;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"The development";
        
               
        self.items = [NSMutableArray array];
       
        for (int i = 0; i < 10; i++)
        {
            [items addObject:[NSNumber numberWithInt:i]];
        }
        


        //floors = [[[NSMutableArray alloc] init] retain];
        
       /* for (int i = 0; i < 6; i++){
            
            CGRect frame = CGRectMake(10+ (i * 50),5,50,50);
            
            UIView* background = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
            [background setBackgroundColor:[UIColor blackColor]];
            [aview addSubview:background];
            aview.background = background;
            [aview addSubview:background];
            
            UIImageView *aview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apartmentwindow.png"]];
            aview.frame = frame;
            [aview setBackgroundColor:[UIColor whiteColor]];
            [self.view addSubview:aview];
            [floors addObject:aview];
            [aview release];
        }*/
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

/*
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   
    UITouch *touch = [touches anyObject]; 
	CGPoint touchLocation = [touch locationInView:self.view];
	
    for (UIView* aview in floors){ 
        if (CGRectContainsPoint( aview.frame , touchLocation)){
            [aview removeFromSuperview];
            [self.view addSubview:aview];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.75];
            [UIView setAnimationDelegate:self];
            
            aview.backgroundColor = [UIColor yellowColor];
            
            
                aview.frame = self.view.frame;
               
            
            [UIView commitAnimations];
            return;
        }
    }
}*/

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *wall = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wall.png"]];
    [self.view addSubview:wall];
    [wall release];

    self.carousel = [[iCarousel alloc] initWithFrame:self.view.frame];
    carousel.delegate = self;
    carousel.dataSource = self;
    carousel.type = iCarouselTypeCoverFlow;
    wrap = YES;
    [self.view addSubview:carousel];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark UIActionSheet methods

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //restore view opacities to normal
    for (UIView *view in carousel.visibleViews)
    {
        view.alpha = 1.0;
    }
    
    carousel.type = buttonIndex;
    //navItem.title = [actionSheet buttonTitleAtIndex:buttonIndex];
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    NSLog(@"number of items is %d", [items count]);
    return [items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    if (USE_BUTTONS)
    {
        //create a numbered button
        UIImage *image = [UIImage imageNamed:@"apartmentwindow.png"];
        //UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)] autorelease];
        UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, APARTMENT_SIZE,APARTMENT_SIZE)] autorelease];
        
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setTitle:[[items objectAtIndex:index] stringValue] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [button.titleLabel.font fontWithSize:50];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = index;
        return button;
    }
    else
    {
        //create a numbered view
        UIView *view = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apartmentwindow.png"]] autorelease];
        //view.frame = CGRectMake(0,0,APARTMENT_SIZE,APARTMENT_SIZE);
        UILabel *label = [[[UILabel alloc] initWithFrame:view.bounds] autorelease];
        label.text = [[items objectAtIndex:index] stringValue];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        [view addSubview:label];
        return view;
    }
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
	//note: placeholder views are only displayed if wrapping is disabled
	return 2;
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index
{
	//create a placeholder view
	UIView *view = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apartmentwindow.png"]] autorelease];
    view.frame = CGRectMake(0,0,APARTMENT_SIZE,APARTMENT_SIZE);
	UILabel *label = [[[UILabel alloc] initWithFrame:view.bounds] autorelease];
	label.text = (index == 0)? @"[": @"]";
	label.backgroundColor = [UIColor clearColor];
	label.textAlignment = UITextAlignmentCenter;
	label.font = [label.font fontWithSize:50];
	[view addSubview:label];
	return view;
}

- (float)carouselItemWidth:(iCarousel *)carousel
{
    //slightly wider than item view
    return ITEM_SPACING;
}

- (CATransform3D)carousel:(iCarousel *)_carousel transformForItemView:(UIView *)view withOffset:(float)offset
{
    //implement 'flip3D' style carousel
    
    //set opacity based on distance from camera
    view.alpha = 1.0 - fminf(fmaxf(offset, 0.0), 1.0);
    
    //do 3d transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = self.carousel.perspective;
    transform = CATransform3DRotate(transform, M_PI / 8.0, 0, 1.0, 0);
    return CATransform3DTranslate(transform, 0.0, 0.0, offset * carousel.itemWidth);
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    //wrap all carousels
    return wrap;
}

- (void)carouselWillBeginDragging:(iCarousel *)carousel
{
	NSLog(@"Carousel will begin dragging");
}

- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate
{
	NSLog(@"Carousel did end dragging and %@ decelerate", decelerate? @"will": @"won't");
}

- (void)carouselWillBeginDecelerating:(iCarousel *)carousel
{
	NSLog(@"Carousel will begin decelerating");
}

- (void)carouselDidEndDecelerating:(iCarousel *)carousel
{
	NSLog(@"Carousel did end decelerating");
}

- (void)carouselWillBeginScrollingAnimation:(iCarousel *)carousel
{
	NSLog(@"Carousel will begin scrolling");
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
	NSLog(@"Carousel did end scrolling");
}

- (void)carousel:(iCarousel *)_carousel didSelectItemAtIndex:(NSInteger)index
{
	if (index == carousel.currentItemIndex)
	{
		//note, this will only ever happen if USE_BUTTONS == NO
		//otherwise the button intercepts the tap event
		NSLog(@"Selected current item");
	}
	else
	{
		NSLog(@"Selected item number %i", index);
	}
}

#pragma mark -
#pragma mark Button tap event

- (void)buttonTapped:(UIButton *)sender
{
    [[[[UIAlertView alloc] initWithTitle:@"Button Tapped"
                                 message:[NSString stringWithFormat:@"You tapped button number %i", sender.tag]
                                delegate:nil
                       cancelButtonTitle:@"OK"
                       otherButtonTitles:nil] autorelease] show];
}


@end
