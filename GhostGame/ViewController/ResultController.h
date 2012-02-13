//
//  ResultController.h
//  GhostGame
//
//  Created by  on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *resultDescriptionLabel;
@property (retain, nonatomic) IBOutlet UILabel *promptLabel;
@property (retain, nonatomic) IBOutlet UIButton *guessRightButton;
@property (retain, nonatomic) IBOutlet UIButton *guessWrongButton;

- (IBAction)clickGuessRightButton:(id)sender;
- (IBAction)clickGuessWrongButton:(id)sender;

@end
