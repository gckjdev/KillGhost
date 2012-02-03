//
//  PlayerCard.h
//  GhostGame
//
//  Created by  on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

enum CARD_STATUS {
    UNSHOW = 0,
    SHOWING = 1,
    SHOWED = 2
};

#import <UIKit/UIKit.h>
@class Player;

@interface PlayerCard : UIView<UIGestureRecognizerDelegate>
{
    CGImageRef imageRef;
    CGSize imageSize;
    CGSize cardSize;
    
}

@property(nonatomic, retain)Player *player;
@property(nonatomic, assign)CGFloat scale;
@property(nonatomic, assign)CGFloat fontSize;
@property(nonatomic ,assign)NSInteger status;
@property(nonatomic, assign)CGPoint position;

- (id)initWithPlayer:(Player *)player position:(CGPoint)position;
- (void)setScale:(CGFloat)scale center:(CGPoint)center;

@end
