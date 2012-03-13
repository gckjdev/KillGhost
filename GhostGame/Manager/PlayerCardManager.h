//
//  PlayerCardManager.h
//  GhostGame
//
//  Created by  on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "PlayerCard.h"
@class Game;

@protocol VoteDelegate <NSObject>

@optional
- (void)willPickCandidate:(PlayerCard *)playerCard;
- (void)didPickedCandidate:(PlayerCard *)playerCard;
@end

@protocol PickRoleDelegate <NSObject>

@optional
- (void)didPickedJudge:(PlayerCard *)Judge;
@end


@interface PlayerCardManager : NSObject<PlayerCardDelegate>
{
    NSInteger _pickIndex;
    PlayerCard *_showingCard;
    NSMutableArray *_playerList;
    NSMutableArray *_playerCardList;
    Game *_game;

}
@property(nonatomic, readonly) PlayerCard *showingCard;
@property(nonatomic, retain) NSMutableArray *playerCardList;
@property(nonatomic, assign) id<VoteDelegate>voteDelegate;
@property(nonatomic, assign) id<PickRoleDelegate>pickRoleDelegate;

@property(nonatomic, retain) NSMutableArray *playerList;
@property(nonatomic, retain) Game *game;
@property(nonatomic, readonly) NSInteger judgeIndex;

+ (PlayerCardManager *)defaultManager;
- (PlayerCard *)playerCardAtIndex:(NSInteger)index;
- (NSInteger)indexOfPlayerCard:(PlayerCard *)playerCard;
- (NSInteger)playerCardCount;
- (void)reset;
- (void)createUncertainCardsWithGame:(Game *)game;
- (void)createCertainCardsWithJudgeIndex:(NSInteger)index;
- (void)uncertainAllPlayers;


@end
extern PlayerCardManager *GlobalGetPlayerCardManager();
