//
//  ResultController.h
//  GhostGame
//
//  Created by  on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FooterView.h"
#import "DialogView.h"

@class PlayerCard;

@interface ResultController : UIViewController

@property (retain, nonatomic) UIButton *guessRightButton;
@property (retain, nonatomic) UIButton *guessWrongButton;
@property (retain, nonatomic) UIButton *quitButton;
@property (retain, nonatomic) UIButton *againButton;
@property (retain, nonatomic) PlayerCard *currentPlayerCard;
@property (assign, nonatomic) NSInteger result;
@property (retain, nonatomic) UIImageView *lightImageView;
@property (assign, nonatomic) NSInteger lightIndex;
@property (retain, nonatomic) FooterView *footerView;
@property (retain, nonatomic) DialogView *dialogView;
@property (retain, nonatomic) IBOutlet UILabel *viewTitleLabel;
@property (retain, nonatomic) NSTimer *lightChangeTimer;

- (void)continueGame:(id)sender;

- (id)initWithCurrentPlayerCard:(PlayerCard *)currentPlayerCardValue;
- (void)showResult;


@end
