//
//  VoteController.h
//  GhostGame
//
//  Created by  on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerCardManager.h"
#import "FooterView.h"

@class PlayerCardManager;
@class LineSegment;
@class LineSegmentView;
@class ChangeVoteNumberController;

@interface VoteController : UIViewController<UIGestureRecognizerDelegate, VoteDelegate, UIAlertViewDelegate>
{
    PlayerCardManager *_playerManager;
 //   BOOL _isVoteLine;
    BOOL _isStartInCard, _isEndInCard;
    LineSegment *_voteLine;
    LineSegmentView *_currentVoteLine;
}

@property(nonatomic, retain) PlayerCardManager *playerManager;
@property(nonatomic, retain) NSMutableArray *lineViewArray;
@property(nonatomic, retain) ChangeVoteNumberController *changeVoteNumberController;
@property (retain, nonatomic) IBOutlet UIView *mainMenuBarView;
@property (retain, nonatomic) IBOutlet UIButton *mainMenuButton;
@property (retain, nonatomic) PlayerCard *willDeadPlayerCard;
@property (retain, nonatomic) FooterView *footerView;
@property (retain, nonatomic) IBOutlet UILabel *viewTitleLabel;

- (IBAction)finishVote:(id)sender;
- (IBAction)clickShowButton:(id)sender;
- (id)initWithPlayerManager:(PlayerCardManager *)manager;

@end
