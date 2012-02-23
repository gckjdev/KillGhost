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

@end
