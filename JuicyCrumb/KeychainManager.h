//
//  KeychainManager.h
//  BlockPush
//
//  Created by Tom Lodge on 18/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KeychainManager : NSObject {
    NSString *account;
    NSString *password;
}

+ (KeychainManager *)sharedManager;

@property(nonatomic,retain) NSString* account;
@property(nonatomic,retain) NSString* password;

-(BOOL) hasAccountDetails;
-(NSMutableDictionary *) newSearchDictionary:(NSString*)identifier;
-(NSData*)searchKeyChainCopyMatching:(NSString*)identifier;
-(BOOL) createKeyChainValue:(NSString*) password forIdentifier:(NSString*)identifier;
-(BOOL) updateKeyChainValue:(NSString*) password forIdentifier:(NSString*)identifer;
-(void) deleteKeyChainValue:(NSString*)identifier;

-(BOOL) hasAccountDetails;
-(BOOL) hasStoredPassword;
-(BOOL) hasStoredAccount;

-(BOOL) storePassword:(NSString*)password;
-(BOOL) storeAccount:(NSString*)account;
-(void) deleteAccountDetails;

@end
