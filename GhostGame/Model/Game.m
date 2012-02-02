//
//  Game.m
//  GhostGame
//
//  Created by gamy on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Game.h"


@implementation Game
@synthesize ghostNumber = _ghostNumber;
@synthesize civilianNumber = _civilianNumber;
@synthesize foolNumber = _foolNumber;

@synthesize retainGhostNumber = _retainGhostNumber;
@synthesize retainCivilianNumber = _retainCivilianNumber;
@synthesize retainFoolNumber = _retainFoolNumber;

@synthesize ghostWord = _ghostWord;
@synthesize civilianWord = _civilianWord;
@synthesize foolWord = _foolWord;



- (id)initWithGhostNumber:(NSInteger)ghostNumber 
                ghostWord:(NSString *)ghostWord 
           civilianNumber: (NSInteger)civilianNumber 
             civilianWord:(NSString *)civilianWord 
               foolNumber:(NSInteger)foolNumber
                 foolWord:(NSString *)foolWord
{
    self = [super init];
    if (self) {
        self.ghostNumber = ghostNumber;
        self.ghostWord = ghostWord;
        self.civilianNumber = civilianNumber;
        
        self.retainFoolNumber = foolNumber;
        self.retainCivilianNumber = civilianNumber;
        self.retainGhostNumber = ghostNumber;
        
        self.civilianWord = civilianWord;
        self.foolNumber = foolNumber;
        self.foolWord = foolWord;
    }
    return self;
}
- (void)dealloc
{
    [_ghostWord release];
    [_civilianWord release];
    [_foolWord release];
    [super dealloc];
}

@end
