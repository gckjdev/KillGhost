//
//  Words.m
//  GhostGame
//
//  Created by haodong qiu on 12年2月6日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "Words.h"

@implementation Words

@synthesize category = _category;
@synthesize civilianWord = _civilianWord;
@synthesize foolWord = _foolWord;

- (id)initWithCivilianWord:(NSString *)civilianWordValue 
                  foolWord:(NSString *)foolWordValue 
                category:(NSString *)categoryValue
{
    self = [super init];
    if (self) {
        self.civilianWord = civilianWordValue;
        self.foolWord = foolWordValue;
        self.category = categoryValue;
    }
    return self;
}

#define CATEGORY @"CATEGORY"
#define CIVILIAN_WORD @"CIVILIAN_WORD"
#define FOOL_WORD @"FOOL_WORD"

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.category forKey:CATEGORY];
    [aCoder encodeObject:self.civilianWord forKey:CIVILIAN_WORD];
    [aCoder encodeObject:self.foolWord forKey:FOOL_WORD];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.category = [aDecoder decodeObjectForKey:CATEGORY];
        self.civilianWord = [aDecoder decodeObjectForKey:CIVILIAN_WORD];
        self.foolWord = [aDecoder decodeObjectForKey:FOOL_WORD];
    }
    return self;
}

- (BOOL)isEqualToWords:(Words *)words
{
    return words && [self.civilianWord isEqualToString:words.civilianWord] && 
    [self.foolWord isEqualToString:words.foolWord];
}
- (void)dealloc
{
    [_civilianWord release];
    [_foolWord release];
    [_category release];
    [super dealloc];
}

@end
