//
//  PickerWordsCell.m
//  GhostGame
//
//  Created by haodong qiu on 12年2月6日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "PickerWordsCell.h"

@implementation PickerWordsCell
@synthesize civilianWordLabel;
@synthesize foolWordLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [civilianWordLabel release];
    [foolWordLabel release];
    // Configure the view for the selected state
}

@end
