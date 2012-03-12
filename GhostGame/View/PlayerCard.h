//
//  PlayerCard.h
//  GhostGame
//
//  Created by  on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

enum CARD_STATUS {
    UNSHOW = 0,  // if the card unshowed but will not show next time.
    SHOWING = 1,//if the card is showing
    SHOWED = 2,//if the card was showed
    WILLSHOW = 3, //if the card will show next time
    VOTE = 10, //when enter the vote process, but before voting.
    VOTED, //if the card is voted
    CANDIDATE, //if the card has the same vote with other players
    DEAD, //if the role is dead
    EXAMINE = 20,  //show the Identity
    JUDGE = 30, //if the card is judge
    UNCERTAIN = 31 //before picked the judge
    
};




#import <UIKit/UIKit.h>
@class Player;
@class PlayerCardDelegate;
@class PlayerCard;

@protocol PlayerCardDelegate <NSObject>

@optional
- (void)willClickPlayerCard:(PlayerCard *)playerCard;
- (void)didClickedPlayerCard:(PlayerCard *)playerCard;
- (BOOL)respondsToClickPlayerCard:(PlayerCard *)playerCard;


@end

@interface PlayerCard : UIView<UIGestureRecognizerDelegate, UIAlertViewDelegate>
{
    CGImageRef imageRef;
    CGSize imageSize;
    CGSize cardSize;
    NSInteger _status;
    id <PlayerCardDelegate> _delegate;
    NSTimer *_flashTimer;
    BOOL _flashShowed;
}

@property(nonatomic, retain)Player *player;
@property(nonatomic, retain)NSString *passWord;
@property(nonatomic, assign)CGFloat scale;
@property(nonatomic, assign)CGFloat fontSize;
@property(nonatomic, assign)NSInteger status;
@property(nonatomic, assign)CGPoint position;
@property(nonatomic, assign)NSInteger voteNumber;
@property(nonatomic, retain)PlayerCard *voteForPlayer;
@property(nonatomic, assign)id <PlayerCardDelegate>delegate;
@property(nonatomic, assign)NSInteger index;

- (void)show;
- (void)cover;

- (id)initWithPlayer:(Player *)player position:(CGPoint)position;
- (void)setScale:(CGFloat)scale center:(CGPoint)center;

@end


