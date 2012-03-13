//
//  FooterController.m
//  GhostGame
//
//  Created by haodong qiu on 12年3月12日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "FooterController.h"



@interface FooterController ()


@end

@implementation FooterController
@synthesize mainMenuButton;
@synthesize previousButton;
@synthesize nextButton;
@synthesize nextButtonTitle;
@synthesize previousButtonTitle;
@synthesize superView;
@synthesize mainMenuBarView;

- (void)dealloc
{
    [mainMenuButton release];
    [previousButton release];
    [nextButton release];
    [nextButtonTitle release];
    [previousButtonTitle release];
    [superView release];
    [mainMenuBarView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIButton *)createMainMenuButton
{
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-40, 82, 40)] autorelease];
    [button setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    
    return button;
}

- (UIButton *)createPreviousButton
{
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(81, self.view.frame.size.height-38, 96, 38)] autorelease];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"previous.png"]];
    iv.frame= CGRectMake(0, 0, 36, 36);
    [button addSubview:iv];
    [iv release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 64, 38)];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor colorWithRed:0xF3/255.0 green:0xB1/255.0 blue:0x5B/255.0 alpha:1.0];
    label.backgroundColor = [UIColor clearColor];
    label.text =self.nextButtonTitle;
    label.textAlignment = UITextAlignmentLeft;
    [button addSubview:label];
    [label release];
    
    return button;
}

- (UIButton *)createNextButton
{
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(240, self.view.frame.size.height-38, 80, 38)] autorelease];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next.png"]];
    iv.frame= CGRectMake(44, 0, 36, 36);
    [button addSubview:iv];
    [iv release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 38)];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor colorWithRed:0xF3/255.0 green:0xB1/255.0 blue:0x5B/255.0 alpha:1.0];
    label.backgroundColor = [UIColor clearColor];
    label.text =self.nextButtonTitle;
    label.textAlignment = UITextAlignmentRight;
    [button addSubview:label];
    [label release];
    
    return button;
}

- (UIView *)createMainMenuBarView
{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 250, 68, 230)] autorelease];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 17, 68, 213)];
    backgroundImageView.image = [UIImage imageNamed:@"main_menu_bar_bg"];
    [view addSubview:backgroundImageView];
    [backgroundImageView release];
    
    UIImageView *gearImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
    gearImageView.image = [UIImage imageNamed:@"gear.png"];
    [view addSubview:gearImageView];
    [gearImageView release];
    
    return view;
}

- (void)show
{
    [superView addSubview:self.mainMenuBarView];
    
    [self.view addSubview:self.previousButton];
    [self.view addSubview:self.nextButton];
    [self.view addSubview:self.mainMenuButton];
    [superView addSubview:self.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setMainMenuButton:nil];
    [self setPreviousButton:nil];
    [self setNextButton:nil];
    [self setNextButtonTitle:nil];
    [self setPreviousButtonTitle:nil];
    [self setSuperView:nil];
    [self setMainMenuBarView:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setNextButtonAction:(SEL)action target:(id)target
{
    [self.nextButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)clickMainMenuButton123:(id)sender
{
    
}

- (void)setSuperView:(UIView *)superViewValue
        buttonTarget:(id)target
     nextButtonTitle:(NSString *)nextTitle 
     nextButtonActon:(SEL)nextAction
     previousButtonTitle:(NSString *)previoustTitle
     nextButtonActon:(SEL)previoustAction
{
    self.superView = superViewValue;
    self.nextButtonTitle = nextTitle;
    self.previousButtonTitle = previoustTitle;
    
    self.previousButton = [self createPreviousButton];
    self.nextButton = [self createNextButton];
    self.mainMenuButton = [self createMainMenuButton];
    self.mainMenuBarView = [self createMainMenuBarView];
    
    [self.nextButton addTarget:target action:nextAction forControlEvents:UIControlEventTouchUpInside];
    [self.previousButton addTarget:target action:previoustAction forControlEvents:UIControlEventTouchUpInside]; 
    ActionHandler *handler = [ActionHandler defaultHander];
    handler.deletegate = self;
    [self.mainMenuButton addTarget:handler action:@selector(clickMainMenu:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clikedMainMenu
{
    NSLog(@"haha");
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
     
@end

ActionHandler *actionHandler;
ActionHandler *GlobalGetActionHander()
{
    if (actionHandler == nil) {
        actionHandler = [[ActionHandler  alloc] init];
    }
    return actionHandler;
}
@implementation ActionHandler
@synthesize deletegate;

+(ActionHandler *)defaultHander
{
    return GlobalGetActionHander();
}

- (void)clickMainMenu:(id)sender
{
    NSLog(@"clickMainMenu");
    if (self.deletegate && [self.deletegate respondsToSelector:@selector(clikedMainMenu:)]) {
        [self.deletegate clikedMainMenu];
    }
}

@end
