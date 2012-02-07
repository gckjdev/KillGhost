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
#import "PlayerCard.h"

@interface PickRoleController : GRViewController<PlayerCardDelegate> {
    NSMutableArray *_playerList;
    NSMutableArray *_cardList;
    NSInteger _pickIndex;
    PlayerCard *_showingCard;
}

@property(nonatomic, retain)Game *game;
- (IBAction)clickNextButton:(id)sender;
- (id)initWithGame:(Game *)aGame;
@end
