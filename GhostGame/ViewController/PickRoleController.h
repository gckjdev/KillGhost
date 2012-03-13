//
//  PlayGameController.h
//  GhostGame
//
//  Created by gamy on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "GRViewController.h"
#import "PlayerCardManager.h"
#import "TipsController.h"

@class Game;
@class PlayerCardManager;

@interface PickRoleController : GRViewController<PickRoleDelegate> {
    PlayerCardManager *_playerCardManager;
}

@property(nonatomic, retain)Game *game;
@property (retain, nonatomic) IBOutlet UIView *mainMenuBarView;
@property (retain, nonatomic) IBOutlet UIButton *mainMenuButton;
@property (retain, nonatomic) TipsController *tipsController;
@property (retain, nonatomic) IBOutlet UILabel *controllerTitle;

- (IBAction)clickNextButton:(id)sender;
- (IBAction)clickBackButton:(id)sender;
- (id)initWithGame:(Game *)aGame;
@end
