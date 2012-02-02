//
//  PlayGameController.h
//  GhostGame
//
//  Created by gamy on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRViewController.h"
#import "Game.h"

@interface PickRoleController : GRViewController {
    NSMutableArray *_playerList;
    NSMutableArray *_cardList;
}

@property(nonatomic, retain)Game *game;
- (id)initWithGame:(Game *)aGame;
@end
