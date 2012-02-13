//
//  ResultManager.m
//  GhostGame
//
//  Created by haodong qiu on 12年2月13日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "ResultManager.h"
#import "PlayerCardManager.h"
#import "PlayerCard.h"
#import "Player.h"

@implementation ResultManager


+ (NSInteger)resultByOut:(PlayerCardManager *)playerCardManager
{
    int ghostCount=0, ghostOutCount=0, notGhosOutCount=0;
    
    
    for(PlayerCard *card in playerCardManager.playerCardList)
    {
        if (card.player.type == GhostType) 
        {
            ghostCount++; 
            if (card.status == DEAD) {
                ghostOutCount++;
            }
        }
        
        else 
        {
            if (card.status == DEAD) {
                notGhosOutCount++;
            }
        }
    }
    
    if (ghostOutCount == ghostCount) {
        return ResultCivilianWin;
    }
    
    if (notGhosOutCount == ghostCount) {
        return ResultGhostWin;
    }
    
    return ResultContinue;
}

//+ (NSInteger)resultByGuessWord:(BOOL)isRight
//{
//    if (isRight) 
//        return ResultGhostWin;
//    else
//        return ResultContinue;
//}

@end
