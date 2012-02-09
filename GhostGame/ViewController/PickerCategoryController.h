//
//  PickerCategoryController.h
//  GhostGame
//
//  Created by haodong qiu on 12年2月9日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerCategoryController : UIViewController

@property (retain, nonatomic) NSArray *categoryIdArray;
@property (retain, nonatomic) IBOutlet UITableView *categoryTable;
@end
