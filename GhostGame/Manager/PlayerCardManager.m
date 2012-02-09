//
//  PlayerCardManager.m
//  GhostGame
//
//  Created by  on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PlayerCardManager.h"

PlayerCardManager *playerCardManager;
PlayerCardManager *GlobalGetPlayerCardManager()
{
    if (playerCardManager == nil) {
        playerCardManager = [[PlayerCardManager alloc] init];
    }
    return playerCardManager;
}

@implementation PlayerCardManager
@synthesize playerCardList = _playerCardList;
@synthesize showingCard = _showingCard;

- (id)init
{
    self = [super init];
    if (self) {
        _playerCardList = [[NSMutableArray alloc] init];
        _pickIndex = - 1;
    }
    return self;
}

- (void)dealloc
{
    [_playerCardList release];
    [super dealloc];
}

+ (PlayerCardManager *)defaultManager
{
    return GlobalGetPlayerCardManager();
}

- (PlayerCard *)playerCardAtIndex:(NSInteger)index
{
    if(_playerCardList && index >= 0 && index < [_playerCardList  count])
    {
        return [_playerCardList objectAtIndex:index];
    }
    return nil;
}
- (NSInteger)indexOfPlayerCard:(PlayerCard *)playerCard
{
    if (_playerCardList) {
        return [_playerCardList indexOfObject:playerCard];
    }
    return -1;
}

- (NSInteger)playerCardCount
{
    return [_playerCardList count];
}


#pragma mark - PlayerCard Delegate

- (PlayerCard *)getNextWillShowCard
{
    if ([self playerCardCount] != 0) {
        if (_pickIndex < 0) {
            return nil;
        }
        NSInteger index = (_pickIndex + 1) % [self playerCardCount];
        PlayerCard *card = [self playerCardAtIndex:index];
        if (card && card.status != SHOWED) {
            return card;
        }
    }
    return nil;
}

- (BOOL)respondsToClickPlayerCard:(PlayerCard *)playerCard
{
    if (playerCard) {
        
        if (_showingCard && _showingCard != playerCard) {
            return NO;
        }
        
        if (playerCard.status == SHOWING || playerCard.status == SHOWED) {
            return YES;
        }
        if (_pickIndex == -1) {
            _pickIndex = [self indexOfPlayerCard:playerCard];
            for (PlayerCard *card in self.playerCardList) {
                if (card != playerCard) {
                    card.status = UNSHOW;
                }
            }
            return YES;
        }
        PlayerCard *card = [self getNextWillShowCard];
        if (card == playerCard) {
            _pickIndex = [self indexOfPlayerCard:playerCard];
            return YES;
        }
    }
    return NO;
}

- (void)didClickedPlayerCard:(PlayerCard *)playerCard
{
    if (playerCard.scale != 1) {
        _showingCard = playerCard;
    }else{
        _showingCard = nil;
        PlayerCard *card = [self getNextWillShowCard];
        if (card) {
            card.status = WILLSHOW;
        }
    }
}

@end
