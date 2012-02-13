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
@interface PlayerCardManager : NSObject<PlayerCardDelegate>
{
    NSInteger _pickIndex;
    PlayerCard *_showingCard;
    NSMutableArray *_playerList;

}
@property(nonatomic, readonly) PlayerCard *showingCard;
@property(nonatomic, retain)NSMutableArray *playerCardList;

+ (PlayerCardManager *)defaultManager;
- (PlayerCard *)playerCardAtIndex:(NSInteger)index;
- (NSInteger)indexOfPlayerCard:(PlayerCard *)playerCard;
- (NSInteger)playerCardCount;
- (void)reset;
- (void)createCardsFromGame:(Game *)game;
@end
extern PlayerCardManager *GlobalGetPlayerCardManager();