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


#import "JROnipinoL1Object.h"

@interface NSArray (OnipinoL2PluralToFromDictionary)
- (NSArray*)arrayOfOnipinoL2PluralElementsFromOnipinoL2PluralDictionariesWithPath:(NSString*)capturePath;
- (NSArray*)arrayOfOnipinoL2PluralDictionariesFromOnipinoL2PluralElements;
- (NSArray*)arrayOfOnipinoL2PluralReplaceDictionariesFromOnipinoL2PluralElements;
- (BOOL)isEqualToOtherOnipinoL2PluralArray:(NSArray *)otherArray;
@end

@implementation NSArray (OnipinoL2PluralToFromDictionary)
- (NSArray*)arrayOfOnipinoL2PluralElementsFromOnipinoL2PluralDictionariesWithPath:(NSString*)capturePath
{
    NSMutableArray *filteredOnipinoL2PluralArray = [NSMutableArray arrayWithCapacity:[self count]];
    for (NSObject *dictionary in self)
        if ([dictionary isKindOfClass:[NSDictionary class]])
            [filteredOnipinoL2PluralArray addObject:[JROnipinoL2PluralElement onipinoL2PluralElementFromDictionary:(NSDictionary*)dictionary withPath:capturePath]];

    return filteredOnipinoL2PluralArray;
}

- (NSArray*)arrayOfOnipinoL2PluralDictionariesFromOnipinoL2PluralElements
{
    NSMutableArray *filteredDictionaryArray = [NSMutableArray arrayWithCapacity:[self count]];
    for (NSObject *object in self)
        if ([object isKindOfClass:[JROnipinoL2PluralElement class]])
            [filteredDictionaryArray addObject:[(JROnipinoL2PluralElement*)object toDictionary]];

    return filteredDictionaryArray;
}

- (NSArray*)arrayOfOnipinoL2PluralReplaceDictionariesFromOnipinoL2PluralElements
{
    NSMutableArray *filteredDictionaryArray = [NSMutableArray arrayWithCapacity:[self count]];
    for (NSObject *object in self)
        if ([object isKindOfClass:[JROnipinoL2PluralElement class]])
            [filteredDictionaryArray addObject:[(JROnipinoL2PluralElement*)object toReplaceDictionary]];

    return filteredDictionaryArray;
}

- (BOOL)isEqualToOtherOnipinoL2PluralArray:(NSArray *)otherArray
{
    if ([self count] != [otherArray count]) return NO;

    for (NSUInteger i = 0; i < [self count]; i++)
        if (![((JROnipinoL2PluralElement *)[self objectAtIndex:i]) isEqualToOnipinoL2PluralElement:[otherArray objectAtIndex:i]])
            return NO;

    return YES;
}
@end

@interface JROnipinoL1Object ()
@property BOOL canBeUpdatedOrReplaced;
@end

@implementation JROnipinoL1Object
{
    NSString *_string1;
    NSString *_string2;
    NSArray *_onipinoL2Plural;
}
@dynamic string1;
@dynamic string2;
@dynamic onipinoL2Plural;
@synthesize canBeUpdatedOrReplaced;

- (NSString *)string1
{
    return _string1;
}

- (void)setString1:(NSString *)newString1
{
    [self.dirtyPropertySet addObject:@"string1"];
    _string1 = [newString1 copy];
}

- (NSString *)string2
{
    return _string2;
}

- (void)setString2:(NSString *)newString2
{
    [self.dirtyPropertySet addObject:@"string2"];
    _string2 = [newString2 copy];
}

- (NSArray *)onipinoL2Plural
{
    return _onipinoL2Plural;
}

- (void)setOnipinoL2Plural:(NSArray *)newOnipinoL2Plural
{
    [self.dirtyArraySet addObject:@"onipinoL2Plural"];
    _onipinoL2Plural = [newOnipinoL2Plural copy];
}

- (id)init
{
    if ((self = [super init]))
    {
        self.captureObjectPath = @"/onipinoL1Object";
        self.canBeUpdatedOrReplaced = YES;
    }
    return self;
}

+ (id)onipinoL1Object
{
    return [[[JROnipinoL1Object alloc] init] autorelease];
}

- (id)copyWithZone:(NSZone*)zone
{ // TODO: SHOULD PROBABLY NOT REQUIRE REQUIRED FIELDS
    JROnipinoL1Object *onipinoL1ObjectCopy =
                [[JROnipinoL1Object allocWithZone:zone] init];

    onipinoL1ObjectCopy.captureObjectPath = self.captureObjectPath;

    onipinoL1ObjectCopy.string1 = self.string1;
    onipinoL1ObjectCopy.string2 = self.string2;
    onipinoL1ObjectCopy.onipinoL2Plural = self.onipinoL2Plural;
    // TODO: Necessary??
    onipinoL1ObjectCopy.canBeUpdatedOrReplaced = self.canBeUpdatedOrReplaced;
    
    // TODO: Necessary??
    [onipinoL1ObjectCopy.dirtyPropertySet setSet:self.dirtyPropertySet];
    [onipinoL1ObjectCopy.dirtyArraySet setSet:self.dirtyArraySet];

    return onipinoL1ObjectCopy;
}

- (NSDictionary*)toDictionary
{
    NSMutableDictionary *dict = 
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dict setObject:(self.string1 ? self.string1 : [NSNull null])
             forKey:@"string1"];
    [dict setObject:(self.string2 ? self.string2 : [NSNull null])
             forKey:@"string2"];
    [dict setObject:(self.onipinoL2Plural ? [self.onipinoL2Plural arrayOfOnipinoL2PluralDictionariesFromOnipinoL2PluralElements] : [NSNull null])
             forKey:@"onipinoL2Plural"];

    return [NSDictionary dictionaryWithDictionary:dict];
}

+ (id)onipinoL1ObjectObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    if (!dictionary)
        return nil;

    JROnipinoL1Object *onipinoL1Object = [JROnipinoL1Object onipinoL1Object];


    onipinoL1Object.string1 =
        [dictionary objectForKey:@"string1"] != [NSNull null] ? 
        [dictionary objectForKey:@"string1"] : nil;

    onipinoL1Object.string2 =
        [dictionary objectForKey:@"string2"] != [NSNull null] ? 
        [dictionary objectForKey:@"string2"] : nil;

    onipinoL1Object.onipinoL2Plural =
        [dictionary objectForKey:@"onipinoL2Plural"] != [NSNull null] ? 
        [(NSArray*)[dictionary objectForKey:@"onipinoL2Plural"] arrayOfOnipinoL2PluralElementsFromOnipinoL2PluralDictionariesWithPath:onipinoL1Object.captureObjectPath] : nil;

    [onipinoL1Object.dirtyPropertySet removeAllObjects];
    [onipinoL1Object.dirtyArraySet removeAllObjects];
    
    return onipinoL1Object;
}

- (void)updateFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    DLog(@"%@ %@", capturePath, [dictionary description]);

    NSSet *dirtyPropertySetCopy = [[self.dirtyPropertySet copy] autorelease];
    NSSet *dirtyArraySetCopy    = [[self.dirtyArraySet copy] autorelease];

    self.canBeUpdatedOrReplaced = YES;

    if ([dictionary objectForKey:@"string1"])
        self.string1 = [dictionary objectForKey:@"string1"] != [NSNull null] ? 
            [dictionary objectForKey:@"string1"] : nil;

    if ([dictionary objectForKey:@"string2"])
        self.string2 = [dictionary objectForKey:@"string2"] != [NSNull null] ? 
            [dictionary objectForKey:@"string2"] : nil;

    [self.dirtyPropertySet setSet:dirtyPropertySetCopy];
    [self.dirtyArraySet setSet:dirtyArraySetCopy];
}

- (void)replaceFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    DLog(@"%@ %@", capturePath, [dictionary description]);

    NSSet *dirtyPropertySetCopy = [[self.dirtyPropertySet copy] autorelease];
    NSSet *dirtyArraySetCopy    = [[self.dirtyArraySet copy] autorelease];

    self.canBeUpdatedOrReplaced = YES;

    self.string1 =
        [dictionary objectForKey:@"string1"] != [NSNull null] ? 
        [dictionary objectForKey:@"string1"] : nil;

    self.string2 =
        [dictionary objectForKey:@"string2"] != [NSNull null] ? 
        [dictionary objectForKey:@"string2"] : nil;

    self.onipinoL2Plural =
        [dictionary objectForKey:@"onipinoL2Plural"] != [NSNull null] ? 
        [(NSArray*)[dictionary objectForKey:@"onipinoL2Plural"] arrayOfOnipinoL2PluralElementsFromOnipinoL2PluralDictionariesWithPath:self.captureObjectPath] : nil;

    [self.dirtyPropertySet setSet:dirtyPropertySetCopy];
    [self.dirtyArraySet setSet:dirtyArraySetCopy];
}

- (NSDictionary *)toUpdateDictionary
{
    NSMutableDictionary *dict =
         [NSMutableDictionary dictionaryWithCapacity:10];

    if ([self.dirtyPropertySet containsObject:@"string1"])
        [dict setObject:(self.string1 ? self.string1 : [NSNull null]) forKey:@"string1"];

    if ([self.dirtyPropertySet containsObject:@"string2"])
        [dict setObject:(self.string2 ? self.string2 : [NSNull null]) forKey:@"string2"];

    return dict;
}

- (NSDictionary *)toReplaceDictionary
{
    NSMutableDictionary *dict =
         [NSMutableDictionary dictionaryWithCapacity:10];

    [dict setObject:(self.string1 ? self.string1 : [NSNull null]) forKey:@"string1"];
    [dict setObject:(self.string2 ? self.string2 : [NSNull null]) forKey:@"string2"];
    [dict setObject:(self.onipinoL2Plural ? [self.onipinoL2Plural arrayOfOnipinoL2PluralReplaceDictionariesFromOnipinoL2PluralElements] : [NSArray array]) forKey:@"onipinoL2Plural"];

    return dict;
}

- (void)replaceOnipinoL2PluralArrayOnCaptureForDelegate:(id<JRCaptureObjectDelegate>)delegate withContext:(NSObject *)context
{
    [self replaceArrayOnCapture:self.onipinoL2Plural named:@"onipinoL2Plural"
                    forDelegate:delegate withContext:context];
}

- (BOOL)needsUpdate
{
    if ([self.dirtyPropertySet count])
         return YES;

    return NO;
}

- (BOOL)isEqualToOnipinoL1Object:(JROnipinoL1Object *)otherOnipinoL1Object
{
    if ((self.string1 == nil) ^ (otherOnipinoL1Object.string1 == nil)) // xor
        return NO;

    if (![self.string1 isEqualToString:otherOnipinoL1Object.string1])
        return NO;

    if ((self.string2 == nil) ^ (otherOnipinoL1Object.string2 == nil)) // xor
        return NO;

    if (![self.string2 isEqualToString:otherOnipinoL1Object.string2])
        return NO;

    if ((self.onipinoL2Plural == nil) ^ (otherOnipinoL1Object.onipinoL2Plural == nil)) // xor
        return NO;

    if (![self.onipinoL2Plural isEqualToOtherOnipinoL2PluralArray:otherOnipinoL1Object.onipinoL2Plural])
        return NO;

    return YES;
}

- (NSDictionary*)objectProperties
{
    NSMutableDictionary *dict = 
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dict setObject:@"NSString" forKey:@"string1"];
    [dict setObject:@"NSString" forKey:@"string2"];
    [dict setObject:@"NSArray" forKey:@"onipinoL2Plural"];

    return [NSDictionary dictionaryWithDictionary:dict];
}

- (void)dealloc
{
    [_string1 release];
    [_string2 release];
    [_onipinoL2Plural release];

    [super dealloc];
}
@end
