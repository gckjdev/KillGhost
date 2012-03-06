//
//  PickerCategoryController.h
//  GhostGame
//
//  Created by haodong qiu on 12年2月9日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerWordsController.h"

@interface PickerCategoryController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) NSArray *categoryArray;
@property (nonatomic, assign) id<PickWordsDelegate> delegate;
- (IBAction)clickBack:(id)sender;

@end
