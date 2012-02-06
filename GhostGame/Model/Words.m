//
//  Words.m
//  GhostGame
//
//  Created by haodong qiu on 12年2月6日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "Words.h"

@implementation Words

@synthesize civilianWord;
@synthesize foolWord;

- (id)initWithCivilianWord:(NSString *)civilianWordValue 
                  foolWord:(NSString *)foolWordValue
{
    self = [super init];
    if (self) {
        self.civilianWord = civilianWordValue;
        self.foolWord = foolWordValue;
    }
    return self;
}

- (void)dealloc
{
    [civilianWord release];
    [foolWord release];
    [super dealloc];
}

@end
