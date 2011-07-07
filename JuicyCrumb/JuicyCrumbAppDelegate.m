//
//  JuicyCrumbAppDelegate.m
//  JuicyCrumb
//
//  Created by Tom Lodge on 03/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JuicyCrumbAppDelegate.h"
#import "TabBarController.h"
#import "MenuController.h"
#import "ContentController.h"
#import "CrumbDetailController.h"
#import "CliqueMapViewController.h"
#import "CrumbTableSendController.h"
#import "LoginViewController.h"
#import "CrumbSendCliqueController.h"
#import "CreateCliqueMapViewController.h"
#import "CreateCliqueDetailsViewController.h"
#import "JoinCliqueViewController.h"
#import "UserDetailsViewController.h"

@implementation JuicyCrumbAppDelegate


@synthesize window;//=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"am in here...");
    TTNavigator* navigator = [TTNavigator navigator];
    navigator.persistenceMode = TTNavigatorPersistenceModeAll;
    navigator.window = [[[UIWindow alloc] initWithFrame:TTScreenBounds()] autorelease];
    
    
    TTURLMap* map = navigator.URLMap;
    
    [map from:@"tt://tabBar" toSharedViewController:[TabBarController class]];
    // Menu controllers are also shared - we only create one to show in each tab, so opening
    // these URLs will switch to the tab containing the menu
    [map from:@"tt://menu/(initWithMenu:)" toSharedViewController:[MenuController class]];
    
    
    [map from:@"tt://nib/(loadFromNib:)/(withClass:)" toSharedViewController:self];
    
    [map from:@"tt://response/(initWithResponse:)" toViewController:[ContentController class]];
    
    [map from:@"tt://cliques" toSharedViewController:[CliqueMapViewController class]];
    
    [map from:@"tt://detail/(initWithMenu:)" toSharedViewController:[CrumbDetailController class]];
    
    [map from:@"tt://order/food" toModalViewController:[TTPostController class]];
    
    [map from:@"tt://order?waitress=(initWithWaitress:)" toModalViewController:[ContentController class]];
    
    [map from:@"tt://send?cliqueid=(initWithClique:)" toModalViewController:[CrumbTableSendController class]];
    
    [map from:@"tt://send/clique" toViewController:[CrumbSendCliqueController class]];
    
    [map from:@"tt://order/(loadFromNib:)/(withClass:)" toModalViewController:self];
    
    [map from:@"tt://clique/create/map" toViewController:[CreateCliqueMapViewController class]];
    
    [map from:@"tt://clique/create/(initWithLat:)/(andLng:)" toViewController:[CreateCliqueDetailsViewController class]];
    
    [map from:@"tt://clique/join?cliqueId=(initWithClique:)" toViewController:[JoinCliqueViewController class]];

    [map from:@"tt://user/details" toViewController:[UserDetailsViewController class]];

    
    
    /*
     * Stuff for clique creation
     */
    
    [map from: @"tt://clique/create/development/name"
    parent: nil /*@"tt://clique/create/(initWithLat:)/(andLng:)"*/
    toViewController: [LoginViewController class]
    selector: nil
    transition: 0];
    
    [map from: @"tt://clique/create/structure/floors"
    parent: nil /* @"tt://clique/create/(initWithLat:)/(andLng:)"   */
    toViewController: [LoginViewController class]
    selector: nil
    transition: 0];
    
    
    [map from: @"tt://clique/create/structure/blocks"
    parent: nil /*@"tt://clique/create/(initWithLat:)/(andLng:)"*/
    toViewController: [LoginViewController class]
    selector: nil
    transition: 0];
    
    [map from: @"tt://clique/create/development/name"
    parent: nil /*@"tt://clique/create/(initWithLat:)/(andLng:)"*/
    toViewController: [LoginViewController class]
    selector: nil
    transition: 0];
    
    [map from: @"tt://clique/create/development/joining/privacy"
    parent: nil /* @"tt://clique/create/(initWithLat:)/(andLng:)"*/
    toViewController: [LoginViewController class]
    selector: nil
    transition: 0];
   
    [map from: @"tt://clique/create/development/joining/privacy"
    parent: nil /*@"tt://clique/create/(initWithLat:)/(andLng:)"*/
    toViewController: [LoginViewController class]
    selector: nil
    transition: 0];
    
    [map from:  @"tt://clique/create/development/joining/passwords"
    parent: nil /* @"tt://clique/create/(initWithLat:)/(andLng:)"*/
    toViewController: [LoginViewController class]
    selector: nil
    transition: 0];
           
    if (![navigator restoreViewControllers]) {
        // This is the first launch, so we just start with the tab bar
        [navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://tabBar"]];
    }
    // Override point for customization after application launch.
    
     [self.window makeKeyAndVisible];
    return YES;
}

- (UIViewController*)loadFromNib:(NSString *)nibName withClass:className {
    UIViewController* newController = [[NSClassFromString(className) alloc]
                                       initWithNibName:nibName bundle:nil];
    [newController autorelease];
    
    return newController;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
   [window release];
    [super dealloc];
}

@end
