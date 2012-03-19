//
//  FooterView.h
//  GhostGame
//
//  Created by haodong qiu on 12年3月13日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>

enum MAINMENU_VIEW_STATUS {
    CLOSED = 0,
    OPEN = 1
};


@interface FooterView : UIView <UIAlertViewDelegate>
{
    UIViewController *_currentViewController;
    UIViewController *_nextViewController;
    NSInteger _status;
}

@property (nonatomic,retain) UIButton *mainMenuButton;
@property (nonatomic,retain) UIButton *nextButton;
@property (nonatomic,retain) UIButton *previousButton;
@property (nonatomic,retain) UIButton *tipsButton;
@property (retain,nonatomic) UIView *mainMenuBarView;
@property (retain,nonatomic) UIViewController *currentViewController;
@property (retain,nonatomic) UIViewController *nextViewController;
@property (retain,nonatomic) NSString *tips;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) BOOL isCustomPreviousAction;
@property (retain,nonatomic) NSTimer *showTipsTimer;

- (id)init;
- (void)show;
- (void)autoShowTips;

@end
