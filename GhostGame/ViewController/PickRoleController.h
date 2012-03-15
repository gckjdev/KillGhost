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
#import "FooterView.h"

@class Game;
@class PlayerCardManager;

@interface PickRoleController : GRViewController<PickRoleDelegate> {
    PlayerCardManager *_playerCardManager;
}

@property(nonatomic, retain)Game *game;
@property (retain, nonatomic) IBOutlet UIView *mainMenuBarView;
@property (retain, nonatomic) IBOutlet UIButton *mainMenuButton;
@property (retain, nonatomic) IBOutlet UILabel *controllerTitle;
@property (retain, nonatomic) FooterView *footerView;

- (IBAction)clickBackButton:(id)sender;
- (id)initWithGame:(Game *)aGame;
@end
