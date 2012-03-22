//
//  CreateNewGameController.h
//  GhostGame
//
//  Created by haodong qiu on 12年3月2日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRViewController.h"
#import "PickerWordsController.h"
#import "FooterView.h"

@interface CreateNewGameController : GRViewController<PickWordsDelegate, UIAlertViewDelegate>
{
    UILabel *judgeNumberLabel;
    UILabel *ghostNumberLabel;
    UILabel *foolNumberLabel;
    UILabel *civilianNumberLabel;
    
    UITextField *wordLengthTextField;
    UITextField *foolWordTextField;
    UITextField *civilianWordTextField;
    
    UITextField *_currentTextField;
}

@property (retain, nonatomic) IBOutlet UITextField *playerNumberTextField;
@property (retain, nonatomic) IBOutlet UILabel *judgeNumberLabel;
@property (retain, nonatomic) IBOutlet UILabel *ghostNumberLabel;
@property (retain, nonatomic) IBOutlet UILabel *foolNumberLabel;
@property (retain, nonatomic) IBOutlet UILabel *civilianNumberLabel;
@property (retain, nonatomic) IBOutlet UIImageView *judgeNumberImageView;
@property (retain, nonatomic) IBOutlet UIImageView *ghostNumberImageView;
@property (retain, nonatomic) IBOutlet UIImageView *foolNumberImageView;
@property (retain, nonatomic) IBOutlet UIImageView *civilianNumberImageView;
@property (retain, nonatomic) IBOutlet UITextField *wordLengthTextField;
@property (retain, nonatomic) IBOutlet UITextField *foolWordTextField;
@property (retain, nonatomic) IBOutlet UITextField *civilianWordTextField;
@property (retain, nonatomic) FooterView *footerView;

@property (retain, nonatomic) IBOutlet UILabel *viewTitleLabel;
@property (retain, nonatomic) IBOutlet UILabel *firstStepLabel;
@property (retain, nonatomic) IBOutlet UILabel *judgeLabel;
@property (retain, nonatomic) IBOutlet UILabel *ghostLabel;
@property (retain, nonatomic) IBOutlet UILabel *foolLabel;
@property (retain, nonatomic) IBOutlet UILabel *civilianLabel;
@property (retain, nonatomic) IBOutlet UILabel *secondStepLabel;
@property (retain, nonatomic) IBOutlet UILabel *ghostWordLabel;
@property (retain, nonatomic) IBOutlet UILabel *foolWordLabel;
@property (retain, nonatomic) IBOutlet UILabel *civilianWordLabel;


- (IBAction)randomWords:(id)sender;
- (IBAction)pickWords:(id)sender;

@property (retain, nonatomic) IBOutlet UIView *coverView;

@end
