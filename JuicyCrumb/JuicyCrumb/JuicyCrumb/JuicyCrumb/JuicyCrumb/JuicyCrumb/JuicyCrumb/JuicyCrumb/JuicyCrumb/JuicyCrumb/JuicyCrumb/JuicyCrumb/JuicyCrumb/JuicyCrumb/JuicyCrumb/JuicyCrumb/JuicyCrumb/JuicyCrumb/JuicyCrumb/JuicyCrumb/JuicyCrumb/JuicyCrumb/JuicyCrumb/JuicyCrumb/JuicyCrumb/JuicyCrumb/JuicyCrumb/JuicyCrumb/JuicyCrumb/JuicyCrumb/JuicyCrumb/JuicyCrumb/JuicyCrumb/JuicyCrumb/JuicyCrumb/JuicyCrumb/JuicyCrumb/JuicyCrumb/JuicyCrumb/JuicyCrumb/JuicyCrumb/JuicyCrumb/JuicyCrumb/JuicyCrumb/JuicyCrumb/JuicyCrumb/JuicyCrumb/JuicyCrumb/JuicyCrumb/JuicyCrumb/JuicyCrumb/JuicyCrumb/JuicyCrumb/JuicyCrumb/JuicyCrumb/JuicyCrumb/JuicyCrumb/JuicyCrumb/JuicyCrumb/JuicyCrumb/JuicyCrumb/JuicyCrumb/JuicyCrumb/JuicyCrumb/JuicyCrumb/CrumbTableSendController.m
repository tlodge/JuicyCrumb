//
//  CrumbTableSendController.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 06/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CrumbTableSendController.h"
#import "CrumbSendDataSource.h"
#import "TableCheckItem.h"
#import "CheckmarkTableCell.h"

@implementation CrumbTableSendController

- (void)createModel {
    
    UITextView* name = [[[UITextView alloc] init] autorelease];
    name.frame = CGRectMake(0, 0, 100, 100);
    name.font = TTSTYLEVAR(font);
    
    UITextField* email = [[[UITextField alloc] init] autorelease];
    email.placeholder = @"Your email address";
    email.font = TTSTYLEVAR(font);
    
    UITextField* apartmentnumber = [[[UITextField alloc] init] autorelease];
    apartmentnumber.placeholder = @"Your apartment number";
    apartmentnumber.font = TTSTYLEVAR(font);
    
    UITextField* floornumber = [[[UITextField alloc] init] autorelease];
    floornumber.placeholder = @"Your floor number";
    floornumber.font = TTSTYLEVAR(font);
    
    UIImage* defaultPerson = TTIMAGE(@"bundle://left.png");

    
    
    NSString* remoteImage = @"http://profile.ak.fbcdn.net/v223/35/117/q223792_6978.jpg";                   

    
    TTTableSubtitleItem* development =  [TTTableSubtitleItem itemWithText:@"Langbourne place" subtitle:@"everyone in langbourne place"
                                                                 imageURL:nil defaultImage:defaultPerson
                                                                      URL:@"nil" accessoryURL:nil];
    
   
   
    self.dataSource = [CrumbSendDataSource dataSourceWithObjects: 
                       
                       @"What do you want to send?",
                       name,
                       
                       @"Who to?", 
                       [TableCheckItem itemWithText:@"All Langbourne place" state:CheckMarkChecked],
                       [TableCheckItem itemWithText:@"Everyone" state:CheckMarkNone],
                       [TTTableSubtitleItem itemWithText:@"Selected Apartments" subtitle:@"pick and chose the apartments in Langbourne you want to send to" imageURL:nil defaultImage:nil
                                                     URL:@"tt://clique/create/structure/blocks" accessoryURL:nil],
                       [TTTableSubtitleItem itemWithText:@"Selected neighbours" subtitle:@"pick and chose surrounding developments you want to send to" imageURL:nil defaultImage:nil
                                                     URL:@"tt://clique/create/structure/blocks" accessoryURL:nil],
                       nil
                       ];
    selected = nil;
   
   
}

-(void) didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"path is %@", indexPath);
   
    if (selected == nil){
        //bootstrap with default...
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:1];
        NSLog(@"default path is %@",path);
        selected = (CheckmarkTableCell *) [self.tableView cellForRowAtIndexPath:path];
    }
    if (selected != nil)
    {
        if ([selected isKindOfClass:[CheckmarkTableCell class]])
            ((CheckmarkTableCell *)selected).state = CheckMarkNone;
        else
           selected.accessoryType = UITableViewCellAccessoryNone;     
    
    }
    
    
    if ([object isKindOfClass:[TableCheckItem class]]){
         
        CheckmarkTableCell *cell = (CheckmarkTableCell *) [self.tableView cellForRowAtIndexPath:indexPath];
        cell.state = !cell.item.state;
        selected = cell;
                
    }else{
        
        TTTableViewCell* cell = (TTTableViewCell *) [self.tableView cellForRowAtIndexPath:indexPath];
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        selected = cell;
        [super didSelectObject:object atIndexPath:indexPath];
    }
   
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tableViewStyle = UITableViewStyleGrouped;
        self.autoresizesForKeyboard = YES;
        self.variableHeightRows = YES;
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
                                                  initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered
                                                  target:self action:@selector(dismiss)] autorelease];
        
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                                  initWithTitle:@"Send it" style:UIBarButtonItemStyleBordered
                                                  target:self action:@selector(dismiss)] autorelease];
    }
    return self;
}

- (void)dismiss {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc
{
    [super dealloc];
}

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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

@end
