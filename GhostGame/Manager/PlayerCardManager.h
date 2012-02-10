//
//  PlayerCardManager.h
//  GhostGame
//
//  Created by  on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "PlayerCard.h"

@interface PlayerCardManager : NSObject<PlayerCardDelegate>
{
    NSInteger _pickIndex;
    PlayerCard *_showingCard;
}
@property(nonatomic, readonly) PlayerCard *showingCard;
@property(nonatomic, retain)NSMutableArray *playerCardList;

+ (PlayerCardManager *)defaultManager;
- (PlayerCard *)playerCardAtIndex:(NSInteger)index;
- (NSInteger)indexOfPlayerCard:(PlayerCard *)playerCard;
- (NSInteger)playerCardCount;
- (void)reset;
@end
extern PlayerCardManager *GlobalGetPlayerCardManager();