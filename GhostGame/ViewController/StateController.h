//
//  StateController.h
//  GhostGame
//
//  Created by  on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StateController : UIViewController


@property (retain, nonatomic) NSArray * operationTipsArray;
@property (assign,nonatomic) int selectIndex;

@property (retain, nonatomic) IBOutlet UIButton *previousButton;
@property (retain, nonatomic) IBOutlet UIButton *nextButton;

@property (retain, nonatomic) UILabel *operationLabel_0;
@property (retain, nonatomic) UILabel *operationLabel_1;

@property (retain, nonatomic) UIView *operationView_0;
@property (retain, nonatomic) UIView *operationView_1;

- (IBAction)previous:(id)sender;
- (IBAction)next:(id)sender;
- (void)updateView;

- (void)translationOnX:(UIView*)view from:(float)fromValue to:(float)toValue;

- (void)leftIntoAnimation:(UIView*)view;
- (void)leftOutAnimation:(UIView*)view;
- (void)RightIntoAnimation:(UIView*)view;
- (void)RightOutAnimation:(UIView*)view;


- (IBAction)chooseWords:(id)sender;

@end
