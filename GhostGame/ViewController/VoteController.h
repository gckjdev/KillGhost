//
//  VoteController.h
//  GhostGame
//
//  Created by  on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerCardManager;
@interface VoteController : UIViewController<UIGestureRecognizerDelegate>
{
    PlayerCardManager *_playerManager;
    BOOL _isVoteLine;
}

@property(nonatomic, retain)PlayerCardManager *playerManager;
@property(nonatomic, retain)NSMutableArray *lineViewArray;
- (id)initWithPlayerManager:(PlayerCardManager *)manager;
@end
