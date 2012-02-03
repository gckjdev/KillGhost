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
@synthesize operationView_0;
@synthesize operationView_1;
@synthesize operationTipsArray;
@synthesize operationLabel_0;
@synthesize operationLabel_1;
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
    self.operationTipsArray = [NSArray arrayWithObjects:@"1.所有人闭眼",@"2.鬼睁开眼",@"3.鬼商量谁第一个发言",@"4.鬼闭眼",@"5.所有人睁眼",@"6.第一个发言者开始描述,直到全部人描述完毕",@"7.所有人描述完成，进入投票", nil];
    
    self.selectIndex = 0;
    operationView_0 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 320, 180)];
    self.operationView_0.backgroundColor = [UIColor blueColor];
    operationLabel_0 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 180, 60)];
    self.operationLabel_0.text = [operationTipsArray objectAtIndex:self.selectIndex];
    [self.operationView_0 addSubview:operationLabel_0];
    [self.view addSubview:operationView_0];
    
    operationView_1 = [[UIView alloc] initWithFrame:CGRectMake(340, 100, 320, 180)];
    self.operationView_1.backgroundColor = [UIColor blueColor];
     operationLabel_1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 180, 60)];
    //self.nextOrPreviousOperationLabel.text = [operationTipsArray objectAtIndex:self.selectIndex];
    [self.operationView_1 addSubview:operationLabel_1];
    [self.view addSubview:operationView_1];
}

- (void)viewDidUnload
{
    [self setOperationTipsArray:nil];
    [self setOperationLabel_0:nil];
    [self setOperationLabel_1:nil];
    [self setPreviousButton:nil];
    [self setNextButton:nil];
    [self setOperationView_0:nil];
    [self setOperationView_1:nil];
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
    [operationLabel_0 release];
    [operationLabel_1 release];
    [previousButton release];
    [nextButton release];
    [operationView_0 release];
    [operationView_1 release];
    [super dealloc];
}

- (IBAction)previous:(id)sender
{
    if (0 == selectIndex) {
        selectIndex = selectIndex;
    }
    else{
        selectIndex = selectIndex - 1;
    }
    
    
    if (selectIndex % 2 == 0) {
        [self RightOutAnimation:self.operationView_1];
        
        self.operationLabel_0.text = [self.operationTipsArray objectAtIndex:selectIndex];
        [self RightIntoAnimation:self.operationView_0];
    }
    else if (selectIndex % 2 == 1) {
        [self RightOutAnimation:self.operationView_0];
        
        self.operationLabel_1.text = [self.operationTipsArray objectAtIndex:selectIndex];
        [self RightIntoAnimation:self.operationView_1];
    }
    
    
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
    
    
    if (selectIndex % 2 == 1) {
        [self leftOutAnimation:self.operationView_0];
        
        
        self.operationLabel_1.text = [self.operationTipsArray objectAtIndex:selectIndex];
        [self leftIntoAnimation:self.operationView_1];
    }
    
    if (selectIndex % 2 == 0) {
        [self leftOutAnimation:self.operationView_1];
        
        self.operationLabel_0.text = [self.operationTipsArray objectAtIndex:selectIndex];
        [self leftIntoAnimation:self.operationView_0];
    }
    
    
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


- (void)translationOnX:(UIView*)view from:(float)fromValue to:(float)toValue
{
    CABasicAnimation *comeAnimation;
    comeAnimation=[CABasicAnimation animationWithKeyPath:@"position.x"];
    comeAnimation.delegate = self;
    comeAnimation.duration = 0.5;
    comeAnimation.repeatCount = 0;
    comeAnimation.removedOnCompletion = FALSE;
    comeAnimation.fillMode = kCAFillModeForwards;
    comeAnimation.autoreverses = NO;
    comeAnimation.fromValue = [NSNumber numberWithFloat:fromValue];
    comeAnimation.toValue = [NSNumber numberWithFloat:toValue];
    [view.layer addAnimation:comeAnimation forKey:@"animateLayer"];
}


- (void)leftIntoAnimation:(UIView*)view
{
    [self translationOnX:view from:320+self.view.frame.size.width/2 to:self.view.frame.size.width/2];
}

- (void)leftOutAnimation:(UIView*)view
{
    [self translationOnX:view from:self.view.frame.size.width/2 to:-320+self.view.frame.size.width/2];
}

- (void)RightIntoAnimation:(UIView*)view
{
    [self translationOnX:view from:-320+self.view.frame.size.width/2 to:self.view.frame.size.width/2];
}

- (void)RightOutAnimation:(UIView*)view
{
    [self translationOnX:view from:self.view.frame.size.width/2 to:320+self.view.frame.size.width/2];
}


@end
