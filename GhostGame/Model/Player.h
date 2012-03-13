//
//  Player.h
//  GhostGame
//
//  Created by gamy on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//


enum PlayerType {
    UncertainType = -1,
    GhostType = 0,
    CivilianType = 1,
    FoolType = 2,
    JudgeType = 3
};

#import <Foundation/Foundation.h>


@interface Player : NSObject {
    NSInteger _type;
    NSString *_word;
}

@property(nonatomic, assign) NSInteger type;
@property(nonatomic, retain) NSString *word;
- (id)initWithType:(NSInteger)type word:(NSString *)word;
- (NSString *)name;
@end
