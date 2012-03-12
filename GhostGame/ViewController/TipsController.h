//
//  TipsController.h
//  GhostGame
//
//  Created by haodong qiu on 12年3月12日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipsController : UIViewController

@property (retain, nonatomic) NSString *tips;
@property (retain, nonatomic) IBOutlet UILabel *tipsLabel;

- (id)initWithTips:(NSString *)tipsValue;

@end
