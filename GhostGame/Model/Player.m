//
//  Player.m
//  GhostGame
//
//  Created by gamy on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Player.h"


@implementation Player
@synthesize type = _type;
@synthesize alive = _alive;
@synthesize word = _word;


- (id)initWithType:(NSInteger)type word:(NSString *)word alive:(BOOL)alive
{
    self = [super init];
    if (self) {
        self.type = type;
        self.alive = alive;
        self.word = word;
    }
    return self;
}

- (void)dealloc
{
    [_word release];
    [super dealloc];
}

@end
