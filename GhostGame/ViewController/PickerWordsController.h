//
//  PickerWordsController.h
//  GhostGame
//
//  Created by  on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerWordsController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) NSArray *wordsArray;
@property (retain, nonatomic) IBOutlet UITableView *wordsTable;
@property (assign,nonatomic) int selectCellIndex;

@end
