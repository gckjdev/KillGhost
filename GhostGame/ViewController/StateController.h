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
@property (retain, nonatomic) IBOutlet UILabel *operationTips;
@property (assign,nonatomic) int selectIndex;

@property (retain, nonatomic) IBOutlet UIButton *previousButton;
@property (retain, nonatomic) IBOutlet UIButton *nextButton;

@property (retain, nonatomic) IBOutlet UIView *operationView;

- (IBAction)previous:(id)sender;
- (IBAction)next:(id)sender;
- (void)updateView;

@end
