//
//  ChangeVoteNumberController.h
//  GhostGame
//
//  Created by haodong qiu on 12年2月15日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlayerCard;
@interface ChangeVoteNumberController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *voteNumberLabel;
@property (retain, nonatomic) PlayerCard *playerCard;
@property (retain, nonatomic) IBOutlet UIButton *minusOneButton;
@property (retain, nonatomic) IBOutlet UIButton *plusOneButton;
@property (retain, nonatomic) IBOutlet UIImageView *cardIndexImageView;

- (id)initWithPlayerCard:(PlayerCard *)playerCardValue;

- (IBAction)plusOne:(id)sender;
- (IBAction)minusOne:(id)sender;
- (void)updateVoteNumberLabel;
- (void)updateButtonStatus;

@end
