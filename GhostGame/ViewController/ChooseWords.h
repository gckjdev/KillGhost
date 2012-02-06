//
//  ChooseWords.h
//  GhostGame
//
//  Created by haodong qiu on 12年2月6日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Words;

@interface ChooseWords : UIViewController

@property (retain, nonatomic) NSArray *wordsArray;

@property (retain, nonatomic) IBOutlet UITableView *WordsTable;


@end
