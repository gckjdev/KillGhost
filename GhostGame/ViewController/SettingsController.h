//
//  SettingsController.h
//  GhostGame
//
//  Created by  on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRViewController.h"

@interface SettingsController : GRViewController

- (IBAction)clickBack:(id)sender;
- (IBAction)clickSave:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *passwordField;
@property (retain, nonatomic) IBOutlet UISwitch *defaultTipsSwitch;
@property (retain, nonatomic) IBOutlet UISwitch *soundSwitch;
@property (retain, nonatomic) IBOutlet UILabel *resetPasswordLabel;
@property (retain, nonatomic) IBOutlet UILabel *gameSoundLabel;
@property (retain, nonatomic) IBOutlet UILabel *autoTipsLabel;

@property (retain, nonatomic) IBOutlet UILabel *passwordTipsLabel;

@property (retain, nonatomic) IBOutlet UILabel *viewTitleLabel;


@end
