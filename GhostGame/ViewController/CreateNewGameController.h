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

@interface CreateNewGameController : GRViewController<PickWordsDelegate>
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

@property (retain, nonatomic) IBOutlet UIView *mainMenuBarView;


- (IBAction)randomWords:(id)sender;
- (IBAction)pickWords:(id)sender;

- (IBAction)clickMainMenu:(id)sender;
- (IBAction)clickContinue:(id)sender;
- (IBAction)clickSetting:(id)sender;
- (IBAction)clickHelp:(id)sender;
- (IBAction)clickQuit:(id)sender;
- (IBAction)clickTips:(id)sender;

@end
