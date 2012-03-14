//
//  StateController.h
//  GhostGame
//
//  Created by  on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FooterView.h"
#import "DialogView.h"

@interface StateController : UIViewController

@property (assign,nonatomic) int selectIndex;
@property (retain, nonatomic) NSArray * toSayArray;
@property (retain, nonatomic) NSArray * explainArray;
@property (retain, nonatomic) DialogView *dialogView_0;
@property (retain, nonatomic) DialogView *dialogView_1;

@property (retain, nonatomic) FooterView *footerView;

- (void)previous:(id)sender;
- (void)next:(id)sender;

- (void)translationOnX:(UIView*)view from:(float)fromValue to:(float)toValue;

- (void)leftIntoAnimation:(UIView*)view;
- (void)leftOutAnimation:(UIView*)view;
- (void)RightIntoAnimation:(UIView*)view;
- (void)RightOutAnimation:(UIView*)view;


@end
