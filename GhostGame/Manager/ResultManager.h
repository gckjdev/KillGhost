//
//  ResultManager.h
//  GhostGame
//
//  Created by haodong qiu on 12年2月13日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayerCardManager.h"

enum resultType {
    ResultGhostWin = 0,
    ResultCivilianWin = 1,
    ResultContinue = 2
};

@interface ResultManager : NSObject

+ (NSInteger)resultByOut:(PlayerCardManager *)playerCardManager;
+ (NSInteger)resultByGuessWord:(BOOL)isRight;

@end
