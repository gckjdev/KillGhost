//
//  TipsController.m
//  GhostGame
//
//  Created by haodong qiu on 12年3月12日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "TipsController.h"

@interface TipsController ()

@end

@implementation TipsController

@synthesize tips;
@synthesize tipsLabel;

- (id)initWithTips:(NSString *)tipsValue{
    self = [super init];
    if (self ) {
        self.tips = tipsValue;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tipsLabel.text = self.tips;
}

- (void)viewDidUnload
{
    [self setTips:nil];
    [self setTipsLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [tips release];
    [tipsLabel release];
    [super dealloc];
}

- (IBAction)clickBackground:(id)sender
{
    [self.view removeFromSuperview];
}

@end
