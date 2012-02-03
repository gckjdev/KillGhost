//
//  StateController.m
//  GhostGame
//
//  Created by  on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StateController.h"
#import <QuartzCore/QuartzCore.h>

@implementation StateController
@synthesize previousButton;
@synthesize nextButton;
@synthesize operationView;
@synthesize operationTipsArray;
@synthesize operationTips;
@synthesize selectIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.operationTipsArray = [NSArray arrayWithObjects:@"所有人闭眼",@"鬼睁开眼",@"鬼商量谁第一个发言",@"鬼闭眼",@"所有人睁眼",@"第一个发言者开始描述,直到全部人描述完毕",@"所有人描述完成，进入投票", nil];
    self.selectIndex = 0;
    self.operationTips.text = [operationTipsArray objectAtIndex:self.selectIndex];
}

- (void)viewDidUnload
{
    [self setOperationTipsArray:nil];
    [self setOperationTips:nil];
    [self setPreviousButton:nil];
    [self setNextButton:nil];
    [self setOperationView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [operationTipsArray release];
    [operationTips release];
    [previousButton release];
    [nextButton release];
    [operationView release];
    [super dealloc];
}

- (IBAction)previous:(id)sender
{
    if (0 == selectIndex) {
        selectIndex = selectIndex;
    }
    else
        selectIndex = selectIndex - 1;
    
    self.operationTips.text = [self.operationTipsArray objectAtIndex:selectIndex];
    [self updateView];
}

- (IBAction)next:(id)sender
{
    if (selectIndex == [operationTipsArray count] - 1 ) {
        selectIndex = selectIndex;
    }
    else
    {
        selectIndex = selectIndex + 1;
    }
    
    self.operationTips.text = [self.operationTipsArray objectAtIndex:selectIndex];
    
    
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
    theAnimation.delegate = self;
    theAnimation.duration = 0.5;
    theAnimation.repeatCount = 0;
    theAnimation.removedOnCompletion = FALSE;
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.autoreverses = NO;
    theAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(500,200)];
    theAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(100,200)];
    
    [operationView.layer addAnimation:theAnimation forKey:@"animateLayer"];
    
    [self updateView];
}

- (void)updateView
{
    if (0 == selectIndex) {
        self.previousButton.enabled = NO;
    }
    else{
        self.previousButton.enabled = YES;
    }
    
    if ([self.operationTipsArray count] - 1 == selectIndex) {
        self.nextButton.enabled = NO;
    }
    else{
        self.nextButton.enabled = YES;
    }
}


@end
