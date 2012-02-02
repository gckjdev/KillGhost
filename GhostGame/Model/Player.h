//
//  Player.h
//  GhostGame
//
//  Created by gamy on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//


enum PlayerType {
    GhostType = 0,
    CivilianType = 1,
    FoolType = 2
};

#import <Foundation/Foundation.h>


@interface Player : NSObject {
    
}

@property(nonatomic, assign) NSInteger type;
@property(nonatomic, assign, getter = isAlive) BOOL alive;
@property(nonatomic, retain) NSString *word;
- (id)initWithType:(NSInteger)type word:(NSString *)word alive:(BOOL)alive;
@end
