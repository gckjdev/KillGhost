//
//  StateController.m
//  GhostGame
//
//  Created by  on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StateController.h"
#import <QuartzCore/QuartzCore.h>

#import "PickerCategoryController.h"
#import "PickerWordsController.h"
#import "HelpController.h"
#import "ResultController.h"
#import "VoteController.h"
#import "SettingsController.h"

@implementation StateController
@synthesize selectIndex;
@synthesize footerView;
@synthesize dialogView_0;
@synthesize dialogView_1;
@synthesize toSayArray;
@synthesize explainArray;
@synthesize tipsArray;


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

- (void)showFooter
{
    FooterView *fv = [[FooterView alloc] init];
    self.footerView = fv;
    [fv release];
    
    self.footerView.currentViewController = self;
    self.footerView.tips = [self.tipsArray objectAtIndex:selectIndex];
    [self.footerView.previousButton addTarget:self action:@selector(previous:) forControlEvents:UIControlEventTouchUpInside];
    self.footerView.isCustomPreviousAction = YES;
    [self.footerView.nextButton addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView show];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.selectIndex = 0;
    
    DialogView *dialog_0 = [[DialogView alloc] init];
    self.dialogView_0 = dialog_0;
    [dialog_0 release];
    
    DialogView *dialog_1 = [[DialogView alloc] init];
    self.dialogView_1 = dialog_1;
    [dialog_1 release];
    
    self.dialogView_0.toSay.text = [self.toSayArray objectAtIndex:self.selectIndex];
    self.dialogView_0.explain.text = [self.explainArray objectAtIndex:self.selectIndex];
    self.dialogView_0.frame = (CGRect){CGPointMake(0, 100), self.dialogView_0.frame.size};
    self.dialogView_1.frame = (CGRect){CGPointMake(320, 100), self.dialogView_0.frame.size};
    [self.view addSubview:self.dialogView_0];
    [self.view addSubview:self.dialogView_1];
    
    
    //添加左扫、右扫手势
    UISwipeGestureRecognizer *recognizer; 
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)]; 
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)]; 
    [[self view] addGestureRecognizer:recognizer]; 
    [recognizer release]; 
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)]; 
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)]; 
    [[self view] addGestureRecognizer:recognizer]; 
    [recognizer release]; 
    
    
    [self showFooter];
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer { 
    
    if (recognizer.direction==UISwipeGestureRecognizerDirectionLeft) { 
        [self next:nil];
    }
    
    if (recognizer.direction==UISwipeGestureRecognizerDirectionRight) { 
        [self previous:nil];
    }
}

- (void)viewDidUnload
{
    [self setFooterView:nil];
    [self setDialogView_0:nil];
    [self setDialogView_1:nil];
    [self setToSayArray:nil];
    [self setExplainArray:nil];
    [self setTipsArray:nil];
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
    [footerView release];
    [dialogView_0 release];
    [dialogView_0 release];
    [toSayArray release];
    [explainArray release];
    [tipsArray release];
    [super dealloc];
}

- (void)previous:(id)sender
{
    if (0 == selectIndex) {
        selectIndex = selectIndex;
        [self.navigationController popViewControllerAnimated:YES];
        return ;
    }
    else{
        selectIndex = selectIndex - 1;
    }
    
    if (selectIndex % 2 == 0) {
        [self RightOutAnimation:self.dialogView_1];
        
        self.dialogView_0.toSay.text = [self.toSayArray objectAtIndex:selectIndex];
        self.dialogView_0.explain.text = [self.explainArray objectAtIndex:selectIndex];
        [self RightIntoAnimation:self.dialogView_0];
    }
    else if (selectIndex % 2 == 1) {
        [self RightOutAnimation:self.dialogView_0];
        
        self.dialogView_1.toSay.text = [self.toSayArray objectAtIndex:selectIndex];
        self.dialogView_1.explain.text = [self.explainArray objectAtIndex:selectIndex];
        [self RightIntoAnimation:self.dialogView_1];
    }
    
    self.footerView.tips = [self.tipsArray objectAtIndex:selectIndex];
}

- (void)next:(id)sender
{
    if (selectIndex == [self.toSayArray count] - 1 ) {
        selectIndex = selectIndex;
        VoteController *vc = [[VoteController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
        return ;
    }
    else
    {
        selectIndex = selectIndex + 1;
    }
    
    
    if (selectIndex % 2 == 1) {
        [self leftOutAnimation:self.dialogView_0];
        
        self.dialogView_1.toSay.text = [self.toSayArray objectAtIndex:selectIndex];
        self.dialogView_1.explain.text = [self.explainArray objectAtIndex:selectIndex];
        [self leftIntoAnimation:self.dialogView_1];
    }
    
    if (selectIndex % 2 == 0) {
        [self leftOutAnimation:self.dialogView_1];
        
        self.dialogView_0.toSay.text = [self.toSayArray objectAtIndex:selectIndex];
        self.dialogView_0.explain.text = [self.explainArray objectAtIndex:selectIndex];
        [self leftIntoAnimation:self.dialogView_0];
    }
    
    self.footerView.tips = [self.tipsArray objectAtIndex:selectIndex];
}

- (void)translationOnX:(UIView*)view from:(float)fromValue to:(float)toValue
{
    CABasicAnimation *comeAnimation;
    comeAnimation=[CABasicAnimation animationWithKeyPath:@"position.x"];
    comeAnimation.delegate = self;
    comeAnimation.duration = 0.4;
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
