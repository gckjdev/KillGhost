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
@synthesize previousButton;
@synthesize nextButton;
@synthesize operationView_0;
@synthesize operationView_1;
@synthesize mainMenuBarView;
@synthesize mainMenuButton;
@synthesize operationTipsArray;
@synthesize operationLabel_0;
@synthesize operationLabel_1;
@synthesize selectIndex;
@synthesize tipsController;


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
    //self.operationTipsArray = [NSArray arrayWithObjects:@"1.法官宣布:所有玩家闭眼。\n\n\n\n(所有玩家闭眼后，则进入下一步)",@"2.法官宣布:鬼睁开眼,并且商量谁第一个发言。\n\n\n(鬼商量之后,则进入下一步)",@"3.法官宣布:鬼闭眼。\n\n\n\n(所有鬼闭眼后，则进入下一步)",@"4.法官宣布:所有玩家睁眼。\n\n\n\n(所有玩家睁开眼后，则进入下一步)",@"5.法官指定第一个发言者，按顺序开始描述。\n\n\n\n(直到全部玩家描述完毕，则进入下一步)",@"6.法官宣布:进入投票阶段。", nil];
    
    self.selectIndex = 0;
    operationView_0 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 320, 240)];
    UIImageView *imageView_0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dialog_box@2x.png"]];
    imageView_0.frame = CGRectMake(11, 0, 297, 288);
    [self.operationView_0 addSubview:imageView_0];
    [imageView_0 release];
    operationLabel_0 = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 240, 200)];
    self.operationLabel_0.text = [operationTipsArray objectAtIndex:self.selectIndex];
    self.operationLabel_0.backgroundColor = [UIColor clearColor];
    self.operationLabel_0.numberOfLines = 0;
    self.operationLabel_0.lineBreakMode = UILineBreakModeWordWrap;
    self.operationLabel_0.font = [UIFont boldSystemFontOfSize:19];
    [self.operationView_0 addSubview:operationLabel_0];
    [self.view addSubview:operationView_0];
    
    operationView_1 = [[UIView alloc] initWithFrame:CGRectMake(320, 100, 320, 240)];
    UIImageView *imageView_1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dialog_box@2x.png"]];
    imageView_1.frame = CGRectMake(11, 0, 297, 288);
    [self.operationView_1 addSubview:imageView_1];
    [imageView_1 release];
     operationLabel_1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 240, 200)];
    //self.nextOrPreviousOperationLabel.text = 
    self.operationLabel_1.backgroundColor = [UIColor clearColor];
    self.operationLabel_1.numberOfLines = 0;
    self.operationLabel_1.lineBreakMode = UILineBreakModeWordWrap;
    self.operationLabel_1.font = [UIFont boldSystemFontOfSize:19];
    [self.operationView_1 addSubview:operationLabel_1];
    [self.view addSubview:operationView_1];
    
    
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
    
    
    self.mainMenuBarView.frame = (CGRect){CGPointMake(0, 430), self.mainMenuBarView.frame.size};
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer { 
    NSLog(@"Swipe received."); 
    
    if (recognizer.direction==UISwipeGestureRecognizerDirectionLeft) { 
        NSLog(@"swipe left");
        [self next:nil];
    }
    
    if (recognizer.direction==UISwipeGestureRecognizerDirectionRight) { 
        NSLog(@"swipe right");
        [self previous:nil];
    }
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
    [self setMainMenuBarView:nil];
    [self setMainMenuButton:nil];
    [self setTipsController:nil];
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
    [mainMenuBarView release];
    [mainMenuButton release];
    [tipsController release];
    [super dealloc];
}

- (IBAction)previous:(id)sender
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
        self.previousButton.enabled = YES;
    }
    else{
        self.previousButton.enabled = YES;
    }
    
    if ([self.operationTipsArray count] - 1 == selectIndex) {
        self.nextButton.enabled = YES;
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


- (IBAction)clickMainMenu:(id)sender
{
    [self.view bringSubviewToFront:self.mainMenuBarView];
    [self.view bringSubviewToFront:self.mainMenuButton];
    if (self.mainMenuBarView.frame.origin.y < 345) {
        [UIView beginAnimations:@"downMainMenu" context:nil];
        self.mainMenuBarView.frame = (CGRect){CGPointMake(0, 430), self.mainMenuBarView.frame.size};
        [UIView commitAnimations];
    }
    else{
        [UIView beginAnimations:@"upMainMenu" context:nil];
        self.mainMenuBarView.frame = (CGRect){CGPointMake(0, 230), self.mainMenuBarView.frame.size};
        [UIView commitAnimations];
    }
}

- (IBAction)clickContinue:(id)sender
{
    
}

- (IBAction)clickSetting:(id)sender
{
    SettingsController *settings = [[SettingsController alloc] init];
    [self.navigationController pushViewController:settings animated:YES];
    [settings release];
}

- (IBAction)clickHelp:(id)sender
{
    HelpController *hc = [[HelpController alloc] init];
    [self.navigationController pushViewController:hc animated:YES];
    [hc release];
}

- (IBAction)clickQuit:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)clickTips:(id)sender
{
    TipsController *tc = [[TipsController alloc] initWithTips:@"法官按步骤宣读指示"];
    self.tipsController = tc;
    [tc release];
    [self.view addSubview:self.tipsController.view];
}

@end
