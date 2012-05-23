//
//  MainMenuController.h
//  GhostGame
//
//  Created by  on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRViewController.h"

@class GADBannerView;

@interface MainMenuController : GRViewController
{
    
}
@property (retain, nonatomic) IBOutlet UIButton *startGameButton;
@property (retain, nonatomic) IBOutlet UIButton *settingButton;
@property (retain, nonatomic) IBOutlet UIButton *helpButton;
@property (retain, nonatomic) IBOutlet UIImageView *startGameLine;
@property (retain, nonatomic) IBOutlet UIImageView *settingLine;
@property (retain, nonatomic) IBOutlet UIImageView *helpLine;
@property (retain, nonatomic) GADBannerView *bannerView;

- (IBAction)clickHelp:(id)sender;
- (IBAction)clickSettings:(id)sender;

- (IBAction)clickStartGame:(id)sender;
@end
