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


#import "JRPinoinoL2Object.h"

@interface NSArray (PinoinoL3PluralToFromDictionary)
- (NSArray*)arrayOfPinoinoL3PluralObjectsFromPinoinoL3PluralDictionariesWithPath:(NSString*)capturePath;
- (NSArray*)arrayOfPinoinoL3PluralDictionariesFromPinoinoL3PluralObjects;
- (NSArray*)arrayOfPinoinoL3PluralReplaceDictionariesFromPinoinoL3PluralObjects;
@end

@implementation NSArray (PinoinoL3PluralToFromDictionary)
- (NSArray*)arrayOfPinoinoL3PluralObjectsFromPinoinoL3PluralDictionariesWithPath:(NSString*)capturePath
{
    NSMutableArray *filteredPinoinoL3PluralArray = [NSMutableArray arrayWithCapacity:[self count]];
    for (NSObject *dictionary in self)
        if ([dictionary isKindOfClass:[NSDictionary class]])
            [filteredPinoinoL3PluralArray addObject:[JRPinoinoL3PluralElement pinoinoL3PluralObjectFromDictionary:(NSDictionary*)dictionary withPath:capturePath]];

    return filteredPinoinoL3PluralArray;
}

- (NSArray*)arrayOfPinoinoL3PluralDictionariesFromPinoinoL3PluralObjects
{
    NSMutableArray *filteredDictionaryArray = [NSMutableArray arrayWithCapacity:[self count]];
    for (NSObject *object in self)
        if ([object isKindOfClass:[JRPinoinoL3PluralElement class]])
            [filteredDictionaryArray addObject:[(JRPinoinoL3PluralElement*)object toDictionary]];

    return filteredDictionaryArray;
}

- (NSArray*)arrayOfPinoinoL3PluralReplaceDictionariesFromPinoinoL3PluralObjects
{
    NSMutableArray *filteredDictionaryArray = [NSMutableArray arrayWithCapacity:[self count]];
    for (NSObject *object in self)
        if ([object isKindOfClass:[JRPinoinoL3PluralElement class]])
            [filteredDictionaryArray addObject:[(JRPinoinoL3PluralElement*)object toReplaceDictionary]];

    return filteredDictionaryArray;
}
@end

@interface JRPinoinoL2Object ()
@property BOOL canBeUpdatedOrReplaced;
@end

@implementation JRPinoinoL2Object
{
    NSString *_string1;
    NSString *_string2;
    NSArray *_pinoinoL3Plural;
}
@dynamic string1;
@dynamic string2;
@dynamic pinoinoL3Plural;
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

- (NSArray *)pinoinoL3Plural
{
    return _pinoinoL3Plural;
}

- (void)setPinoinoL3Plural:(NSArray *)newPinoinoL3Plural
{
    [self.dirtyArraySet addObject:@"pinoinoL3Plural"];
    _pinoinoL3Plural = [newPinoinoL3Plural copy];
}

- (id)init
{
    if ((self = [super init]))
    {
        self.captureObjectPath = @"/pinoinoL1Object/pinoinoL2Object";
        self.canBeUpdatedOrReplaced = YES;
    }
    return self;
}

+ (id)pinoinoL2Object
{
    return [[[JRPinoinoL2Object alloc] init] autorelease];
}

- (id)copyWithZone:(NSZone*)zone
{ // TODO: SHOULD PROBABLY NOT REQUIRE REQUIRED FIELDS
    JRPinoinoL2Object *pinoinoL2ObjectCopy =
                [[JRPinoinoL2Object allocWithZone:zone] init];

    pinoinoL2ObjectCopy.captureObjectPath = self.captureObjectPath;

    pinoinoL2ObjectCopy.string1 = self.string1;
    pinoinoL2ObjectCopy.string2 = self.string2;
    pinoinoL2ObjectCopy.pinoinoL3Plural = self.pinoinoL3Plural;
    // TODO: Necessary??
    pinoinoL2ObjectCopy.canBeUpdatedOrReplaced = self.canBeUpdatedOrReplaced;
    
    // TODO: Necessary??
    [pinoinoL2ObjectCopy.dirtyPropertySet setSet:self.dirtyPropertySet];
    [pinoinoL2ObjectCopy.dirtyArraySet setSet:self.dirtyArraySet];

    return pinoinoL2ObjectCopy;
}

- (NSDictionary*)toDictionary
{
    NSMutableDictionary *dict = 
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dict setObject:(self.string1 ? self.string1 : [NSNull null])
             forKey:@"string1"];
    [dict setObject:(self.string2 ? self.string2 : [NSNull null])
             forKey:@"string2"];
    [dict setObject:(self.pinoinoL3Plural ? [self.pinoinoL3Plural arrayOfPinoinoL3PluralDictionariesFromPinoinoL3PluralObjects] : [NSNull null])
             forKey:@"pinoinoL3Plural"];

    return [NSDictionary dictionaryWithDictionary:dict];
}

+ (id)pinoinoL2ObjectObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    if (!dictionary)
        return nil;

    JRPinoinoL2Object *pinoinoL2Object = [JRPinoinoL2Object pinoinoL2Object];


    pinoinoL2Object.string1 =
        [dictionary objectForKey:@"string1"] != [NSNull null] ? 
        [dictionary objectForKey:@"string1"] : nil;

    pinoinoL2Object.string2 =
        [dictionary objectForKey:@"string2"] != [NSNull null] ? 
        [dictionary objectForKey:@"string2"] : nil;

    pinoinoL2Object.pinoinoL3Plural =
        [dictionary objectForKey:@"pinoinoL3Plural"] != [NSNull null] ? 
        [(NSArray*)[dictionary objectForKey:@"pinoinoL3Plural"] arrayOfPinoinoL3PluralObjectsFromPinoinoL3PluralDictionariesWithPath:pinoinoL2Object.captureObjectPath] : nil;

    [pinoinoL2Object.dirtyPropertySet removeAllObjects];
    [pinoinoL2Object.dirtyArraySet removeAllObjects];
    
    return pinoinoL2Object;
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

    self.pinoinoL3Plural =
        [dictionary objectForKey:@"pinoinoL3Plural"] != [NSNull null] ? 
        [(NSArray*)[dictionary objectForKey:@"pinoinoL3Plural"] arrayOfPinoinoL3PluralObjectsFromPinoinoL3PluralDictionariesWithPath:self.captureObjectPath] : nil;

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
    [dict setObject:(self.pinoinoL3Plural ? [self.pinoinoL3Plural arrayOfPinoinoL3PluralReplaceDictionariesFromPinoinoL3PluralObjects] : [NSArray array]) forKey:@"pinoinoL3Plural"];

    return dict;
}

- (void)replacePinoinoL3PluralArrayOnCaptureForDelegate:(id<JRCaptureObjectDelegate>)delegate withContext:(NSObject *)context
{
    [self replaceArrayOnCapture:self.pinoinoL3Plural named:@"pinoinoL3Plural"
                    forDelegate:delegate withContext:context];
}

- (BOOL)needsUpdate
{
    if ([self.dirtyPropertySet count])
         return YES;

    return NO;
}

- (NSDictionary*)objectProperties
{
    NSMutableDictionary *dict = 
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dict setObject:@"NSString" forKey:@"string1"];
    [dict setObject:@"NSString" forKey:@"string2"];
    [dict setObject:@"NSArray" forKey:@"pinoinoL3Plural"];

    return [NSDictionary dictionaryWithDictionary:dict];
}

- (void)dealloc
{
    [_string1 release];
    [_string2 release];
    [_pinoinoL3Plural release];

    [super dealloc];
}
@end