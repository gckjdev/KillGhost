//
//  CreatGameController.h
//  GhostGame
//
//  Created by gamy on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GRViewController.h"
#import "PickerWordsController.h"

@interface CreateGameController : GRViewController<UITableViewDataSource, UITableViewDelegate, PickWordsDelegate> {
    
    UITextField *ghostNumber;
    UITextField *civilianNumber;
    UITextField *foolNumber;
    UITextField *wordLength;
    UITextField *civilianWord;
    UITextField *foolWord;
    UITextField *_currentTextField;
}

@property (nonatomic, retain)  UITextField *ghostNumber;
@property (nonatomic, retain)  UITextField *civilianNumber;
@property (nonatomic, retain)  UITextField *foolNumber;

@property (nonatomic, retain)  UITextField *wordLength;
@property (nonatomic, retain)  UITextField *civilianWord;
@property (nonatomic, retain)  UITextField *foolWord;
@property (retain, nonatomic)  UITextField *playerNumber;
@property (retain, nonatomic)  UITableView *stepTable;


- (IBAction)clickNewGame:(id)sender;

//Ghost civilians fool
@end
