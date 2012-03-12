//
//  FooterController.h
//  GhostGame
//
//  Created by haodong qiu on 12年3月12日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FooterController : UIViewController


@property (nonatomic,retain) UIButton *mainMenuButton;
@property (nonatomic,retain) UIButton *nextButton;
@property (nonatomic,retain) UIButton *previousButton;
@property (nonatomic,retain) NSString *nextButtonTitle;
@property (nonatomic,retain) NSString *previousButtonTitle;
@property (nonatomic,retain) UIView *superView;
@property (retain,nonatomic) UIView *mainMenuBarView;

- (void)show;

- (void)setNextButtonAction:(SEL)action target:(id)target;

- (void)setSuperView:(UIView *)superViewValue
        buttonTarget:(id)target
     nextButtonTitle:(NSString *)nextTitle 
     nextButtonActon:(SEL)nextAction
 previousButtonTitle:(NSString *)previoustTitle
     nextButtonActon:(SEL)previoustAction;

- (IBAction)clickMainMenuButton123:(id)sender;

@end
