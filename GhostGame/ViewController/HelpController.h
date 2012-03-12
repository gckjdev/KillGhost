//
//  HelpController.h
//  GhostGame
//
//  Created by haodong qiu on 12年2月7日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FooterController.h"

@interface HelpController : UIViewController

@property (retain, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (retain, nonatomic) IBOutlet UIScrollView *flowChartScrollView;

@property (retain, nonatomic) FooterController *footerController;

- (IBAction)clickBack:(id)sender;
@end
