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
@synthesize pickRoleDelegate = _pickRoleDelegate;
@synthesize playerList = _playerList;
@synthesize game = _game;
@synthesize judgeIndex;

- (void)reset
{
    if (_playerCardList) {
        [_playerCardList removeAllObjects];
    }else{
        _playerCardList = [[NSMutableArray alloc] init];
    }
    
    if (_playerList) {
        [_playerList removeAllObjects];
    }else{
        _playerList = [[NSMutableArray alloc] init];
    }
    
    
    _pickIndex = -1;
    judgeIndex = -1;
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
    [_game release];
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


- (void)createPlayerListWithCount:(NSInteger)count
{
    [_playerList removeAllObjects];

    for (int i = 0; i < count; ++ i) {
        Player *player = [[Player alloc]init];
        [_playerList addObject:player];
        [player release];
    }
}

//- (void)createPlayerListFromGame:(Game *)game;
//{
//    [_playerList removeAllObjects];
//    srand(time(0));
//    if (game) {
//        NSInteger count = game.foolNumber + game.ghostNumber + game.civilianNumber;
//        NSInteger total = count;
//        NSInteger fCount = game.foolNumber;
//        NSInteger gCount = game.ghostNumber;
//        NSInteger cCount = game.civilianNumber;
//        for (int i = 0; i < count; ++ i) {
//            Player *player = nil;
//            int r = rand() % total;
//            if (r < fCount) {
//                //fool
//                player = [[Player alloc] initWithType:FoolType word:game.foolWord];// alive:YES];
//                fCount -- ;
//            }else if( r < fCount + gCount){
//                //ghost
//                player = [[Player alloc] initWithType:GhostType word:game.ghostWord];// alive:YES];
//                gCount --;
//            }else{
//                //civilian
//                player = [[Player alloc] 
//                          initWithType:CivilianType word:game.civilianWord]; //alive:YES];
//                cCount --;
//            }
//            total --;
//            [_playerList addObject:player];
//            [player release];
//        }
//    }
//}

- (void)createCardsFromPlayerList:(NSArray *)playerList
{
    if (_playerList != playerList) {
        self.playerList = [NSMutableArray arrayWithArray:playerList];        
    }
    NSInteger i = 0;
    NSInteger count = [_playerList count];
    [_playerCardList removeAllObjects];
    for (Player *player in _playerList) {
        CGPoint center = CGPointMake(cosf(M_PI * 2.0 * i / count - M_PI_2) * 138 + 160, sinf(M_PI * 2.0 / count * i - M_PI_2) * 138 + 260);
        PlayerCard *card = [[PlayerCard alloc] initWithPlayer:player position:center showIngindex:++i status:UNCERTAIN];
        card.delegate = self;
        [_playerCardList addObject:card];
        [card release];
    }
}
- (BOOL)isAllCardsShow
{
    for (PlayerCard *card in self.playerCardList) {
        if (card.status != JUDGE && card.status != SHOWED) {
            return NO;
        }
    }
    return YES;
}

- (void)createUncertainCardsWithGame:(Game *)game
{
    [self reset];
    self.game = game;
    if (game) {
        [self createPlayerListWithCount:[game playerCount]];
        [self createCardsFromPlayerList:self.playerList];
    }

}
- (void)createCertainCardsWithJudgeIndex:(NSInteger)index
{
    judgeIndex = index;
    if (index < 0 || index >= [_playerList count]) {
        return;
    }
    Player *judge = [_playerList objectAtIndex:index];
    [judge setType:JudgeType];
    
    NSInteger count = [_game playerCount] - 1;
    NSInteger total = count;
    NSInteger fCount = _game.foolNumber;
    NSInteger gCount = _game.ghostNumber;
    NSInteger cCount = _game.civilianNumber;
    srand(time(0));
    for (int i = 0; i < count; ++ i) {
        Player *player = [_playerList objectAtIndex:(index + 1 + i) % [_playerList count]];
        int r = (ABS(rand() + time(0))) % total;
        if (r < fCount) {
            //fool
            [player setType:FoolType];
            [player setWord:self.game.foolWord];
            fCount -- ;
        }else if( r < fCount + gCount){
            //ghost
            [player setType:GhostType];
            [player setWord:self.game.ghostWord];
            gCount --;
 
        }else{
            //civilian
            [player setType:CivilianType];
            [player setWord:self.game.civilianWord];
            cCount --;
        }
        total --;
    }
}

- (void)uncertainAllPlayers
{
    for (Player *player in _playerList) {
        [player setType:UncertainType];
        [player setWord:nil];
    }
    for (PlayerCard *playerCard in _playerCardList) {
        [playerCard setStatus:UNCERTAIN];
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
        if (card && card.status != SHOWED && card.status != JUDGE) {
            return card;
        }
    }
    return nil;
}

- (BOOL)respondsToClickPlayerCard:(PlayerCard *)playerCard
{
    if (playerCard) {
        if (playerCard.status == DEAD || playerCard.status == VOTED || playerCard.status == EXAMINE || playerCard.status == JUDGE) {
            return NO;
        }
        
        if (playerCard.status == VOTE || playerCard.status == CANDIDATE) {
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
- (void)willClickPlayerCard:(PlayerCard *)playerCard
{
    if (playerCard.status == VOTE) {
        if (self.voteDelegate && [self.voteDelegate respondsToSelector:@selector(willPickCandidate:)]) {
            [self.voteDelegate willPickCandidate:playerCard];
        }
    }
}
- (void)didClickedPlayerCard:(PlayerCard *)playerCard
{
    if (playerCard.scale != 1) {
        _showingCard = playerCard;
    }else{
        _showingCard = nil;
        
        if (playerCard.status == VOTE) {
            return;
        }
        
        if (playerCard.status == CANDIDATE) {
            for (PlayerCard * card in _playerCardList) {
                if (card.status != DEAD && card.status != JUDGE) {
                    NSInteger voteNumber = card.voteNumber;
                    card.status = VOTE;
                    card.voteNumber = voteNumber;
                }
            }
            if (self.voteDelegate && [self.voteDelegate respondsToSelector:@selector(didPickedCandidate:)]) {
                [self.voteDelegate didPickedCandidate:playerCard];
            }
            return;
        }
        
        if (playerCard.status == DEAD) {
            for (PlayerCard * card in _playerCardList) {
                if (card.status != DEAD && card.status != JUDGE) {
                    card.status = VOTE;
                }
            }
            if (self.voteDelegate && [self.voteDelegate respondsToSelector:@selector(didPickedCandidate:)]) {
                [self.voteDelegate didPickedCandidate:playerCard];
            }
            return;
        }
        
        if (playerCard.status == JUDGE) {
            [[PlayerCardManager defaultManager] createCertainCardsWithJudgeIndex:playerCard.index - 1];

            if (self.pickRoleDelegate && [self.pickRoleDelegate respondsToSelector:@selector(didPickedJudge:)]) {
                [self.pickRoleDelegate didPickedJudge:playerCard];
            }
            
        }
        
        if (playerCard.status == SHOWED) { 
            if (self.pickRoleDelegate && [self.pickRoleDelegate respondsToSelector:@selector(didpickedplayercard:)]) {
                [self.pickRoleDelegate didpickedplayercard:playerCard];
            }
        }
        
        PlayerCard *card = [self getNextWillShowCard];
        if (card) {
            card.status = WILLSHOW;
        }
    }
}

@end
