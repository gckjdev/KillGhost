//
//  PlayGameController.h
//  GhostGame
//
//  Created by gamy on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "GRViewController.h"
#import "PlayerCard.h"

@class Game;
@class PlayerCardManager;

@interface PickRoleController : GRViewController<PlayerCardDelegate> {
    PlayerCardManager *_playerCardManager;
}

@property(nonatomic, retain)Game *game;
- (IBAction)clickNextButton:(id)sender;
- (IBAction)clickBackButton:(id)sender;
- (id)initWithGame:(Game *)aGame;
@end
