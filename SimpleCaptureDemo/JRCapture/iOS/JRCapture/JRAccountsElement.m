/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 Copyright (c) 2012, Janrain, Inc.

 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation and/or
   other materials provided with the distribution.
 * Neither the name of the Janrain, Inc. nor the names of its
   contributors may be used to endorse or promote products derived from this
   software without specific prior written permission.


 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...)
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)


#import "JRAccountsElement.h"

@interface JRAccountsElement ()
@property BOOL canBeUpdatedOrReplaced;
@end

@implementation JRAccountsElement
{
    JRObjectId *_accountsElementId;
    NSString *_domain;
    JRBoolean *_primary;
    NSString *_userid;
    NSString *_username;
}
@dynamic accountsElementId;
@dynamic domain;
@dynamic primary;
@dynamic userid;
@dynamic username;
@synthesize canBeUpdatedOrReplaced;

- (JRObjectId *)accountsElementId
{
    return _accountsElementId;
}

- (void)setAccountsElementId:(JRObjectId *)newAccountsElementId
{
    [self.dirtyPropertySet addObject:@"accountsElementId"];
    _accountsElementId = [newAccountsElementId copy];
}

- (NSString *)domain
{
    return _domain;
}

- (void)setDomain:(NSString *)newDomain
{
    [self.dirtyPropertySet addObject:@"domain"];
    _domain = [newDomain copy];
}

- (JRBoolean *)primary
{
    return _primary;
}

- (void)setPrimary:(JRBoolean *)newPrimary
{
    [self.dirtyPropertySet addObject:@"primary"];
    _primary = [newPrimary copy];
}

- (BOOL)getPrimaryBoolValue
{
    return [_primary boolValue];
}

- (void)setPrimaryWithBool:(BOOL)boolVal
{
    [self.dirtyPropertySet addObject:@"primary"];
    _primary = [NSNumber numberWithBool:boolVal];
}

- (NSString *)userid
{
    return _userid;
}

- (void)setUserid:(NSString *)newUserid
{
    [self.dirtyPropertySet addObject:@"userid"];
    _userid = [newUserid copy];
}

- (NSString *)username
{
    return _username;
}

- (void)setUsername:(NSString *)newUsername
{
    [self.dirtyPropertySet addObject:@"username"];
    _username = [newUsername copy];
}

- (id)init
{
    if ((self = [super init]))
    {
        self.captureObjectPath      = @"";
        self.canBeUpdatedOrReplaced = NO;
    }
    return self;
}

+ (id)accountsElement
{
    return [[[JRAccountsElement alloc] init] autorelease];
}

- (id)copyWithZone:(NSZone*)zone
{ // TODO: SHOULD PROBABLY NOT REQUIRE REQUIRED FIELDS
    JRAccountsElement *accountsElementCopy =
                [[JRAccountsElement allocWithZone:zone] init];

    accountsElementCopy.captureObjectPath = self.captureObjectPath;

    accountsElementCopy.accountsElementId = self.accountsElementId;
    accountsElementCopy.domain = self.domain;
    accountsElementCopy.primary = self.primary;
    accountsElementCopy.userid = self.userid;
    accountsElementCopy.username = self.username;
    // TODO: Necessary??
    accountsElementCopy.canBeUpdatedOrReplaced = self.canBeUpdatedOrReplaced;
    
    // TODO: Necessary??
    [accountsElementCopy.dirtyPropertySet setSet:self.dirtyPropertySet];
    [accountsElementCopy.dirtyArraySet setSet:self.dirtyArraySet];

    return accountsElementCopy;
}

- (NSDictionary*)toDictionary
{
    NSMutableDictionary *dict = 
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dict setObject:(self.accountsElementId ? [NSNumber numberWithInteger:[self.accountsElementId integerValue]] : [NSNull null])
             forKey:@"id"];
    [dict setObject:(self.domain ? self.domain : [NSNull null])
             forKey:@"domain"];
    [dict setObject:(self.primary ? [NSNumber numberWithBool:[self.primary boolValue]] : [NSNull null])
             forKey:@"primary"];
    [dict setObject:(self.userid ? self.userid : [NSNull null])
             forKey:@"userid"];
    [dict setObject:(self.username ? self.username : [NSNull null])
             forKey:@"username"];

    return [NSDictionary dictionaryWithDictionary:dict];
}

+ (id)accountsElementFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    if (!dictionary)
        return nil;

    JRAccountsElement *accountsElement = [JRAccountsElement accountsElement];

    accountsElement.captureObjectPath = [NSString stringWithFormat:@"%@/%@#%d", capturePath, @"accounts", [(NSNumber*)[dictionary objectForKey:@"id"] integerValue]];
// TODO: Is this safe to assume?
    accountsElement.canBeUpdatedOrReplaced = YES;

    accountsElement.accountsElementId =
        [dictionary objectForKey:@"id"] != [NSNull null] ? 
        [NSNumber numberWithInteger:[(NSNumber*)[dictionary objectForKey:@"id"] integerValue]] : nil;

    accountsElement.domain =
        [dictionary objectForKey:@"domain"] != [NSNull null] ? 
        [dictionary objectForKey:@"domain"] : nil;

    accountsElement.primary =
        [dictionary objectForKey:@"primary"] != [NSNull null] ? 
        [NSNumber numberWithBool:[(NSNumber*)[dictionary objectForKey:@"primary"] boolValue]] : nil;

    accountsElement.userid =
        [dictionary objectForKey:@"userid"] != [NSNull null] ? 
        [dictionary objectForKey:@"userid"] : nil;

    accountsElement.username =
        [dictionary objectForKey:@"username"] != [NSNull null] ? 
        [dictionary objectForKey:@"username"] : nil;

    [accountsElement.dirtyPropertySet removeAllObjects];
    [accountsElement.dirtyArraySet removeAllObjects];
    
    return accountsElement;
}

- (void)updateFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    DLog(@"%@ %@", capturePath, [dictionary description]);

    NSSet *dirtyPropertySetCopy = [[self.dirtyPropertySet copy] autorelease];
    NSSet *dirtyArraySetCopy    = [[self.dirtyArraySet copy] autorelease];

    self.canBeUpdatedOrReplaced = YES;
    self.captureObjectPath = [NSString stringWithFormat:@"%@/%@#%d", capturePath, @"accounts", [(NSNumber*)[dictionary objectForKey:@"id"] integerValue]];

    if ([dictionary objectForKey:@"id"])
        self.accountsElementId = [dictionary objectForKey:@"id"] != [NSNull null] ? 
            [NSNumber numberWithInteger:[(NSNumber*)[dictionary objectForKey:@"id"] integerValue]] : nil;

    if ([dictionary objectForKey:@"domain"])
        self.domain = [dictionary objectForKey:@"domain"] != [NSNull null] ? 
            [dictionary objectForKey:@"domain"] : nil;

    if ([dictionary objectForKey:@"primary"])
        self.primary = [dictionary objectForKey:@"primary"] != [NSNull null] ? 
            [NSNumber numberWithBool:[(NSNumber*)[dictionary objectForKey:@"primary"] boolValue]] : nil;

    if ([dictionary objectForKey:@"userid"])
        self.userid = [dictionary objectForKey:@"userid"] != [NSNull null] ? 
            [dictionary objectForKey:@"userid"] : nil;

    if ([dictionary objectForKey:@"username"])
        self.username = [dictionary objectForKey:@"username"] != [NSNull null] ? 
            [dictionary objectForKey:@"username"] : nil;

    [self.dirtyPropertySet setSet:dirtyPropertySetCopy];
    [self.dirtyArraySet setSet:dirtyArraySetCopy];
}

- (void)replaceFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    DLog(@"%@ %@", capturePath, [dictionary description]);

    NSSet *dirtyPropertySetCopy = [[self.dirtyPropertySet copy] autorelease];
    NSSet *dirtyArraySetCopy    = [[self.dirtyArraySet copy] autorelease];

    self.canBeUpdatedOrReplaced = YES;
    self.captureObjectPath = [NSString stringWithFormat:@"%@/%@#%d", capturePath, @"accounts", [(NSNumber*)[dictionary objectForKey:@"id"] integerValue]];

    self.accountsElementId =
        [dictionary objectForKey:@"id"] != [NSNull null] ? 
        [NSNumber numberWithInteger:[(NSNumber*)[dictionary objectForKey:@"id"] integerValue]] : nil;

    self.domain =
        [dictionary objectForKey:@"domain"] != [NSNull null] ? 
        [dictionary objectForKey:@"domain"] : nil;

    self.primary =
        [dictionary objectForKey:@"primary"] != [NSNull null] ? 
        [NSNumber numberWithBool:[(NSNumber*)[dictionary objectForKey:@"primary"] boolValue]] : nil;

    self.userid =
        [dictionary objectForKey:@"userid"] != [NSNull null] ? 
        [dictionary objectForKey:@"userid"] : nil;

    self.username =
        [dictionary objectForKey:@"username"] != [NSNull null] ? 
        [dictionary objectForKey:@"username"] : nil;

    [self.dirtyPropertySet setSet:dirtyPropertySetCopy];
    [self.dirtyArraySet setSet:dirtyArraySetCopy];
}

- (NSDictionary *)toUpdateDictionary
{
    NSMutableDictionary *dict =
         [NSMutableDictionary dictionaryWithCapacity:10];

    if ([self.dirtyPropertySet containsObject:@"domain"])
        [dict setObject:(self.domain ? self.domain : [NSNull null]) forKey:@"domain"];

    if ([self.dirtyPropertySet containsObject:@"primary"])
        [dict setObject:(self.primary ? [NSNumber numberWithBool:[self.primary boolValue]] : [NSNull null]) forKey:@"primary"];

    if ([self.dirtyPropertySet containsObject:@"userid"])
        [dict setObject:(self.userid ? self.userid : [NSNull null]) forKey:@"userid"];

    if ([self.dirtyPropertySet containsObject:@"username"])
        [dict setObject:(self.username ? self.username : [NSNull null]) forKey:@"username"];

    return dict;
}

- (NSDictionary *)toReplaceDictionary
{
    NSMutableDictionary *dict =
         [NSMutableDictionary dictionaryWithCapacity:10];

    [dict setObject:(self.domain ? self.domain : [NSNull null]) forKey:@"domain"];
    [dict setObject:(self.primary ? [NSNumber numberWithBool:[self.primary boolValue]] : [NSNull null]) forKey:@"primary"];
    [dict setObject:(self.userid ? self.userid : [NSNull null]) forKey:@"userid"];
    [dict setObject:(self.username ? self.username : [NSNull null]) forKey:@"username"];

    return dict;
}

- (BOOL)needsUpdate
{
    if ([self.dirtyPropertySet count])
         return YES;

    return NO;
}

- (BOOL)isEqualToAccountsElement:(JRAccountsElement *)otherAccountsElement
{
    if ((self.domain == nil) ^ (otherAccountsElement.domain == nil)) // xor
        return NO;

    if (![self.domain isEqualToString:otherAccountsElement.domain])
        return NO;

    if ((self.primary == nil) ^ (otherAccountsElement.primary == nil)) // xor
        return NO;

    if (![self.primary isEqualToNumber:otherAccountsElement.primary])
        return NO;

    if ((self.userid == nil) ^ (otherAccountsElement.userid == nil)) // xor
        return NO;

    if (![self.userid isEqualToString:otherAccountsElement.userid])
        return NO;

    if ((self.username == nil) ^ (otherAccountsElement.username == nil)) // xor
        return NO;

    if (![self.username isEqualToString:otherAccountsElement.username])
        return NO;

    return YES;
}

- (NSDictionary*)objectProperties
{
    NSMutableDictionary *dict = 
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dict setObject:@"JRObjectId" forKey:@"accountsElementId"];
    [dict setObject:@"NSString" forKey:@"domain"];
    [dict setObject:@"JRBoolean" forKey:@"primary"];
    [dict setObject:@"NSString" forKey:@"userid"];
    [dict setObject:@"NSString" forKey:@"username"];

    return [NSDictionary dictionaryWithDictionary:dict];
}

- (void)dealloc
{
    [_accountsElementId release];
    [_domain release];
    [_primary release];
    [_userid release];
    [_username release];

    [super dealloc];
}
@end
