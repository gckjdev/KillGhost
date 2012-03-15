//
//  DialogView.m
//  GhostGame
//
//  Created by haodong qiu on 12年3月14日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "DialogView.h"

@implementation DialogView
@synthesize toSay;
@synthesize explain;

- (void)dealloc
{
    [toSay release];
    [explain release];
    [super dealloc];
}

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 100, 320, 300)];
    if (self) {
        [self createImage];
        [self createLabel];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)createImage
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dialog_box.png"]];
    imageView.frame = CGRectMake(11, 0, 297, 288);
    [self addSubview:imageView];
    [imageView release];
}

- (void)createLabel
{
    UILabel *toSayLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 16, 240, 90)];
    toSayLabel.backgroundColor = [UIColor clearColor];
    //toSayLabel.backgroundColor = [UIColor blueColor];
    toSayLabel.numberOfLines = 0;
    toSayLabel.lineBreakMode = UILineBreakModeWordWrap;
    toSayLabel.font = [UIFont boldSystemFontOfSize:19];
    self.toSay = toSayLabel;
    [toSayLabel release];
    [self addSubview:self.toSay];
    
    
    UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 114, 240, 60)];
    explainLabel.backgroundColor = [UIColor clearColor];
    //explainLabel.backgroundColor = [UIColor yellowColor];
    explainLabel.numberOfLines = 0;
    explainLabel.lineBreakMode = UILineBreakModeWordWrap;
    explainLabel.font = [UIFont boldSystemFontOfSize:18];
    self.explain = explainLabel;
    [explainLabel release];
    [self addSubview:self.explain];
}


@end
