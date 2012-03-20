//
//  ShowPlayerCardsController.h
//  GhostGame
//
//  Created by  on 12-2-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowPlayerCardsController : UIViewController
@property (retain, nonatomic) IBOutlet UILabel *viewTitleLabel;
@property (retain, nonatomic) IBOutlet UILabel *backLabel;

- (IBAction)clickBackButton:(id)sender;

@end
