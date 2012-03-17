//
//  HelpController.h
//  GhostGame
//
//  Created by haodong qiu on 12年2月7日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpController : UIViewController

@property (retain, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (retain, nonatomic) IBOutlet UIScrollView *flowChartScrollView;
@property (retain, nonatomic) IBOutlet UIButton *TextButton;
@property (retain, nonatomic) IBOutlet UIButton *ImageButton;

@property (retain, nonatomic) IBOutlet UIImageView *TriangleImageView;

- (IBAction)clickBack:(id)sender;
@end
