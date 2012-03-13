//
//  FooterController.h
//  GhostGame
//
//  Created by haodong qiu on 12年3月12日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActionHandlerDeletegate <NSObject>
@optional
- (void)clikedMainMenu;

@end



@interface FooterController : UIViewController <ActionHandlerDeletegate>


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


@end





@interface ActionHandler : NSObject

@property (nonatomic,assign) id<ActionHandlerDeletegate> deletegate;

+(ActionHandler *)defaultHander;
- (void)clickMainMenu:(id)sender;

@end;
extern ActionHandler *GlobalGetActionHander();
