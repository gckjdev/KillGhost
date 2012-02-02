//
//  CreatGameController.h
//  GhostGame
//
//  Created by gamy on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GRViewController.h"
@interface CreateGameController : GRViewController {
    
    UITextField *ghostNumber;
    UITextField *civilianNumber;
    UITextField *foolNumber;
    UITextField *wordLength;
    UITextField *civilianWord;
    UITextField *foolWord;
}

@property (nonatomic, retain) IBOutlet UITextField *ghostNumber;
@property (nonatomic, retain) IBOutlet UITextField *civilianNumber;
@property (nonatomic, retain) IBOutlet UITextField *foolNumber;

@property (nonatomic, retain) IBOutlet UITextField *wordLength;
@property (nonatomic, retain) IBOutlet UITextField *civilianWord;
@property (nonatomic, retain) IBOutlet UITextField *foolWord;
- (IBAction)clickNewGame:(id)sender;

//Ghost civilians fool
@end
