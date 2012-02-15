//
//  PlayerCardManager.m
//  GhostGame
//
//  Created by  on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PlayerCardManager.h"
#import "Game.h"
#import "Player.h"

PlayerCardManager *defaultPlayerCardManager;
PlayerCardManager *GlobalGetPlayerCardManager()
{
    if (defaultPlayerCardManager == nil) {
        defaultPlayerCardManager = [[PlayerCardManager alloc] init];
    }
    return defaultPlayerCardManager;
}

@implementation PlayerCardManager
@synthesize playerCardList = _playerCardList;
@synthesize showingCard = _showingCard;
@synthesize voteDelegate = _voteDelegate;

- (void)reset
{
    if (_playerCardList) {
        [_playerCardList removeAllObjects];
        [_playerList removeAllObjects];
    }else{
        _playerCardList = [[NSMutableArray alloc] init];
        _playerList = [[NSMutableArray alloc] init];
    }
    _pickIndex = -1;
    _showingCard = nil;
}
- (id)init
{
    self = [super init];
    if (self) {
        [self reset];
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


- (void)createPlayerListFromGame:(Game *)game;
{
    [_playerList removeAllObjects];
    srand(time(0));
    if (game) {
        NSInteger count = game.foolNumber + game.ghostNumber + game.civilianNumber;
        NSInteger total = count;
        NSInteger fCount = game.foolNumber;
        NSInteger gCount = game.ghostNumber;
        NSInteger cCount = game.civilianNumber;
        for (int i = 0; i < count; ++ i) {
            Player *player = nil;
            int r = rand() % total;
            if (r < fCount) {
                //fool
                player = [[Player alloc] initWithType:FoolType word:game.foolWord alive:YES];
                fCount -- ;
            }else if( r < fCount + gCount){
                //ghost
                player = [[Player alloc] initWithType:GhostType word:game.ghostWord alive:YES];
                gCount --;
            }else{
                //civilian
                player = [[Player alloc] 
                          initWithType:CivilianType word:game.civilianWord alive:YES];
                cCount --;
            }
            total --;
            [_playerList addObject:player];
            [player release];
        }
    }
}
- (void)createCardsFromGame:(Game *)game;
{
    [self reset];
    [self createPlayerListFromGame:game];
    NSInteger i = 0;
    NSInteger count = [_playerList count];
    for (Player *player in _playerList) {
        CGPoint center = CGPointMake(cosf(M_PI * 2.0 * i / count - M_PI_2) * 128 + 160, sinf(M_PI * 2.0 / count * i - M_PI_2) * 160 + 240);
        PlayerCard *card = [[PlayerCard alloc] initWithPlayer:player position:center];
        card.delegate = self;
        card.index = ++i;
        [_playerCardList addObject:card];
        [card release];
    }
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
        if (playerCard.status == VOTE || playerCard.status == DEAD || playerCard.status == VOTED) {
            return NO;
        }
        
        if (playerCard.status == CANDIDATE) {
            return YES;
        }
        
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
        
        if (playerCard.status == DEAD) {
            for (PlayerCard * card in _playerCardList) {
                if (card.status != DEAD ) {
                    card.status = VOTE;
                }
            }
            if (self.voteDelegate && [self.voteDelegate respondsToSelector:@selector(didPickedCandidate:)]) {
                [self.voteDelegate didPickedCandidate:playerCard];
            }
            return;
        }
        
        PlayerCard *card = [self getNextWillShowCard];
        if (card) {
            card.status = WILLSHOW;
        }
    }
}

@end
