//
//  KeychainManager.m
//  BlockPush
//
//  Created by Tom Lodge on 18/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "KeychainManager.h"

@interface KeychainManager()
@end



@implementation KeychainManager

@synthesize password;
@synthesize account;

static NSString *serviceName = @"com.block49.BlockPush";


+ (KeychainManager *)sharedManager
{
    static KeychainManager * sKeychainManager;
    
    if (sKeychainManager == nil) {
        @synchronized (self) {
            sKeychainManager = [[KeychainManager alloc] init];
            assert(sKeychainManager != nil);
        }
    }
    return sKeychainManager;
}

- (id)init
{
    // any thread, but serialised by +sharedManager
    self = [super init];
    if (self != nil) {
        
        NSData *passwordData = [self searchKeyChainCopyMatching:@"password"];
        
        if (passwordData){
            NSString* tmppass = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
            self.password = tmppass;
            [passwordData release];
            [tmppass release];
        }
        
        NSData *accountData = [self searchKeyChainCopyMatching:@"account"];
        
        if (accountData){
            NSString *tmpaccount = [[NSString alloc] initWithData:accountData encoding:NSUTF8StringEncoding];
            self.account = tmpaccount;
            [accountData release];
            [tmpaccount release];
        }
    }
    return self;
}



#pragma mark -
#pragma mark Keychain management

-(BOOL) storePassword:(NSString*)pword{
    BOOL success = NO;
    if (![self hasStoredPassword]){
        success = [self createKeyChainValue:pword forIdentifier:@"password"];
    }else{
        success = [self updateKeyChainValue:pword forIdentifier:@"password"];
    }
    if (success)
        self.password = pword;
    
    return success;
}

-(BOOL) storeAccount:(NSString*)acc{
    BOOL success = NO;
    if (![self hasStoredAccount]){
        success = [self createKeyChainValue:acc forIdentifier:@"account"];
    }else{
        success = [self updateKeyChainValue:acc forIdentifier:@"account"];
    }
    if (success)
        self.account = acc;
    
    return success;
}

-(void) deleteAccountDetails{
    [self deleteKeyChainValue:@"password"];
    [self deleteKeyChainValue:@"account"];
    self.password = nil;
    self.account = nil;
}

-(BOOL) hasAccountDetails{
    return [self hasStoredAccount] && [self hasStoredPassword];
}

-(BOOL) hasStoredPassword{
    return [self searchKeyChainCopyMatching:@"password"] != nil;
}

-(BOOL) hasStoredAccount{
    return [self searchKeyChainCopyMatching:@"account"] != nil;
}

-(NSMutableDictionary *) newSearchDictionary:(NSString*)identifier{
    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc]init];
    [searchDictionary setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    NSData* encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    [searchDictionary setObject:encodedIdentifier forKey:(id) kSecAttrGeneric];
    [searchDictionary setObject:encodedIdentifier forKey:(id) kSecAttrAccount];
    [searchDictionary setObject:serviceName forKey:(id)kSecAttrService];
    return searchDictionary;
}

-(NSData*)searchKeyChainCopyMatching:(NSString*)identifier{
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    //Add search attributes
    [searchDictionary setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    //Add search return types
    [searchDictionary setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    NSData* result = nil;
    //OSStatus status = 
    SecItemCopyMatching((CFDictionaryRef)searchDictionary, (CFTypeRef*) &result);
    [searchDictionary release];
    return  result;
}

-(BOOL) createKeyChainValue:(NSString*) pass forIdentifier:(NSString*)identifier{
    NSMutableDictionary *dictionary = [self newSearchDictionary:identifier];
    NSData *paswordData = [pass dataUsingEncoding:NSUTF8StringEncoding];
    [dictionary setObject:paswordData forKey:(id)kSecValueData];
    OSStatus status = SecItemAdd((CFDictionaryRef)dictionary, NULL);
    [dictionary release];
    if (status == errSecSuccess){
        return YES;
    }
    return NO;
}

-(BOOL) updateKeyChainValue:(NSString*) pass forIdentifier:(NSString*)identifer{
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifer];
    NSMutableDictionary *updateDictionary = [[NSMutableDictionary alloc] init];
    NSData *passwordData = [pass dataUsingEncoding:NSUTF8StringEncoding];
    [updateDictionary setObject:passwordData forKey:(id)kSecValueData];
    OSStatus status = SecItemUpdate((CFDictionaryRef)searchDictionary, (CFDictionaryRef) updateDictionary);
    [searchDictionary release];
    [updateDictionary release];
    if (status == errSecSuccess){
        return YES;
    }
    return  NO;
}


-(void) deleteKeyChainValue:(NSString*)identifier{
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    SecItemDelete((CFDictionaryRef) searchDictionary);
    [searchDictionary release];
}


@end
