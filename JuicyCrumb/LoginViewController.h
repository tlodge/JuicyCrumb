//
//  LoginViewController.h
//  BlockPush
//
//  Created by Tom Lodge on 12/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewControllerDelegate;

@interface LoginViewController : TTViewController <UITextFieldDelegate> {
	id <LoginViewControllerDelegate> delegate;
	UILabel *cliqueName;
	UILabel *userName;
	UILabel *password;
	UITextField *cliqueTextField;
	UITextField *nameTextField;
	UITextField *passwordTextField;
}

-(IBAction) login:(id)sender;
-(IBAction) cancel:(id)sender;

@property (nonatomic, assign) id <LoginViewControllerDelegate> delegate;
@property(nonatomic, retain) IBOutlet UILabel* cliqueName;
@property(nonatomic, retain) IBOutlet UILabel *userName;
@property(nonatomic, retain) IBOutlet UILabel *password;
@property(nonatomic, retain) IBOutlet UITextField* cliqueTextField;
@property(nonatomic, retain) IBOutlet UITextField* nameTextField;
@property(nonatomic, retain) IBOutlet UITextField* passwordTextField;
@end

@protocol LoginViewControllerDelegate
- (void)loginViewControllerDidLogin:(LoginViewController *)controller user:(NSString*)user password:(NSString*)password;
- (void)loginViewControllerDidCancel:(LoginViewController *)controller;
@end

