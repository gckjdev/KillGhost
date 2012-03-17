//
//  FooterView.m
//  GhostGame
//
//  Created by haodong qiu on 12年3月13日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "FooterView.h"
#import "SettingsController.h"
#import "HelpController.h"
#import "ShowPlayerCardsController.h"
#import "UIUtils.h"
#import "ConfigureManager.h"

#define FRAME_HEIGHT 40
#define MAINMENU_WIDTH 81
#define PREVIOUS_WIDTH 90
#define NEXT_WIDTH 90
#define TIPS_WIDTH 30

@implementation FooterView

@synthesize mainMenuButton;
@synthesize previousButton;
@synthesize nextButton;
@synthesize mainMenuBarView;
@synthesize currentViewController = _currentViewController;
@synthesize nextViewController = _nextViewController;
@synthesize tipsButton;
@synthesize tips;
@synthesize status = _status;
@synthesize isCustomPreviousAction;

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 480-FRAME_HEIGHT, 320, FRAME_HEIGHT)];
    if (self) {
        self.mainMenuBarView = [self createMainMenuBarView];
        self.mainMenuButton = [self createMainMenuButton];
        self.previousButton = [self createPreviousButton:@"上一步"];
        self.nextButton = [self createNextButton:@"下一步"];
        self.tipsButton = [self createTipsButton];
        self.isCustomPreviousAction = NO;
    }
    return self;
}

- (void)dealloc
{
    [mainMenuButton release];
    [previousButton release];
    [nextButton release];
    [mainMenuBarView release];
    [_currentViewController release];
    [_nextViewController release];
    [tipsButton release];
    [tips release];
    [super dealloc];
}

#define HIDEMAINBUTTON_TAG_1 99
//#define HIDEMAINBUTTON_TAG_2 98

- (void)setStatus:(NSInteger)status
{
    _status = status;
    if (status == CLOSED) {
        [UIView beginAnimations:@"downMainMenu" context:nil];
        self.mainMenuBarView.frame = (CGRect){CGPointMake(0, 430), self.mainMenuBarView.frame.size};
        [UIView commitAnimations];
        
        UIView *bv = [self.currentViewController.view viewWithTag:HIDEMAINBUTTON_TAG_1];
        [bv removeFromSuperview];
    }
    else{
        [UIView beginAnimations:@"upMainMenu" context:nil];
        self.mainMenuBarView.frame = (CGRect){CGPointMake(0, 230), self.mainMenuBarView.frame.size};
        [UIView commitAnimations];
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 442)];
        backView.alpha = 0.5;
        backView.backgroundColor = [UIColor blackColor];
        UIButton *hideMainButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 442)];
        [hideMainButton addTarget:self action:@selector(clickMainMenuButton:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:hideMainButton];
        [hideMainButton release];
        backView.tag = HIDEMAINBUTTON_TAG_1;
        [self.currentViewController.view addSubview:backView];
        [backView release];
        
        [_currentViewController.view bringSubviewToFront:self.mainMenuBarView];
        [_currentViewController.view bringSubviewToFront:self];
        
        //UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, MAINMENU_WIDTH, 320-MAINMENU_WIDTH, FRAME_HEIGHT)];
        //view.alpha = 0.5;
        //view.backgroundColor = [UIColor blackColor];
        //UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320-MAINMENU_WIDTH , FRAME_HEIGHT)];
        //button.backgroundColor = [UIColor blackColor];
        //button.tag = HIDEMAINBUTTON_TAG_1;
        //[button addTarget:self action:@selector(clickMainMenuButton:) forControlEvents:UIControlEventTouchUpInside];
        //[view addSubview:button];
        //[button release];
        //[self addSubview:view];
        //[view release];
    }
}

#pragma mark - action

- (void)clickContinue:(id)sender
{
    [self clickMainMenuButton:nil];
}

- (void)clickShowPlayer:(id)sender
{
    self.status = CLOSED;
    [UIUtils showTextView:@"请输入密码" okButtonTitle:@"确定" cancelButtonTitle:@"取消" delegate:self secureTextEntry:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //ok button
        NSString *pw = ((UITextField *)[alertView viewWithTag:kAlertTextViewTag]).text;
        if ([pw isEqualToString:[ConfigureManager getPassword]]) {
            ShowPlayerCardsController *spc = [[ShowPlayerCardsController alloc] init];
            [_currentViewController.navigationController pushViewController:spc animated:YES];
            [spc release];
        }
    }
}

- (void)clickSetting:(id)sender
{
    self.status = CLOSED;
    SettingsController *settings = [[SettingsController alloc] init];
    [_currentViewController.navigationController pushViewController:settings animated:YES];
    [settings release];
}

- (void)clickHelp:(id)sender
{
    self.status = CLOSED;
    HelpController *hc = [[HelpController alloc] init];
    [_currentViewController.navigationController pushViewController:hc animated:YES];
    [hc release];
}

- (IBAction)clickQuit:(id)sender
{
    [_currentViewController.navigationController popToRootViewControllerAnimated:YES];
}

- (void)clickMainMenuButton:(id)sender
{
    [_currentViewController.view bringSubviewToFront:self.mainMenuBarView];
    [_currentViewController.view bringSubviewToFront:self];
    
    if (_status == CLOSED) {
        self.status = OPEN;
    }
    else {
        self.status = CLOSED;
        UIView *backView = [self.currentViewController.view viewWithTag:HIDEMAINBUTTON_TAG_1];
        [backView removeFromSuperview];
    }
}

- (void)clickPrivousButton:(id)sender
{
    if (!isCustomPreviousAction) {
        self.status = CLOSED;
        [_currentViewController.navigationController popViewControllerAnimated:YES];
    }
}

- (void)clickNextButton:(id)sender
{
    self.status = CLOSED;
    if (_nextViewController) {
        [_currentViewController.navigationController pushViewController:_nextViewController animated:YES];
    }
}

#define BACK_BUTTON_TAG 100

- (void)cancelTips:(id)sender
{
    UIView *view = [_currentViewController.view viewWithTag:BACK_BUTTON_TAG];
    [view removeFromSuperview];
}

- (void)clickTipsButton:(id)sender
{
    self.status = CLOSED;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    view.tag = BACK_BUTTON_TAG;
    view.backgroundColor = [UIColor clearColor];
    
    UIView *halfAlphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    halfAlphaView.backgroundColor = [UIColor blackColor];
    halfAlphaView.alpha = 0.5;
    [view addSubview:halfAlphaView];
    [halfAlphaView release];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [button addTarget:self action:@selector(cancelTips:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [button release];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 154, 320, 296)];
    imageView.image = [UIImage imageNamed:@"tips_box.png"];
    //imageView.userInteractionEnabled = YES;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(38, 38, 240, 176)];
    label.backgroundColor = [UIColor clearColor];
    //label.backgroundColor = [UIColor blueColor];
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.textAlignment = UITextAlignmentCenter;
    label.text = self.tips;
    [imageView addSubview:label];
    [label release];
    
    [view addSubview:imageView];
    [imageView release];
    
    [_currentViewController.view addSubview:view];
    [view release];
}


#pragma mark - create button
- (UIButton *)createMainMenuButton
{
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(-2, self.frame.size.height-41, MAINMENU_WIDTH, 41)] autorelease];
    [button setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    
    return button;
}

- (UIButton *)createPreviousButton:(NSString *)previousButtonTitle
{
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(MAINMENU_WIDTH, self.frame.size.height-40, PREVIOUS_WIDTH, 40)] autorelease];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"previous.png"]];
    iv.frame= CGRectMake(-1, 5, 39, 36);
    [button addSubview:iv];
    [iv release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 2, 54, 40)];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor colorWithRed:0xF3/255.0 green:0xB1/255.0 blue:0x5B/255.0 alpha:1.0];
    label.backgroundColor = [UIColor clearColor];
    label.text =previousButtonTitle;
    label.textAlignment = UITextAlignmentLeft;
    [button addSubview:label];
    [label release];
    
    return button;
}

- (UIButton *)createNextButton:(NSString *)nextButtonTitle
{
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(240, self.frame.size.height-40, NEXT_WIDTH, 40)] autorelease];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next.png"]];
    iv.frame= CGRectMake(44, 5, 39, 36);
    [button addSubview:iv];
    [iv release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 51, 40)];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor colorWithRed:0xF3/255.0 green:0xB1/255.0 blue:0x5B/255.0 alpha:1.0];
    label.backgroundColor = [UIColor clearColor];
    label.text =nextButtonTitle;
    label.textAlignment = UITextAlignmentRight;
    [button addSubview:label];
    [label release];
    
    return button;
}

- (UIButton *)createTipsButton
{
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(MAINMENU_WIDTH+(320-MAINMENU_WIDTH)/2-TIPS_WIDTH/2, self.frame.size.height-32, TIPS_WIDTH, 32)] autorelease];
    [button setImage:[UIImage imageNamed:@"bulb.png"] forState:UIControlStateNormal];
    return button;
}

- (UIView *)createMainMenuBarView
{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 230, 68, 243)] autorelease];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 17, 68, 226)];
    backgroundImageView.image = [UIImage imageNamed:@"main_menu_bar_bg"];
    [view addSubview:backgroundImageView];
    [backgroundImageView release];
    
    UIImageView *gearImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
    gearImageView.image = [UIImage imageNamed:@"gear.png"];
    [view addSubview:gearImageView];
    [gearImageView release];
    
    return view;
}

- (void)addButtonToMainMenuBarView
{
    UIButton *button = nil;
    for (int count= 0; count<5; count++) {
        button = [[UIButton alloc] initWithFrame:CGRectMake(0, 32+38*count, 68, 34)];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [button setTitleColor:[UIColor colorWithRed:85/255.0 green:54/255.0 blue:24/255.0 alpha:1.0] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"button_bg_m.png"] forState:UIControlStateHighlighted];
        
        switch (count) {
            case 0:
            {
                [button setTitle:@"继续" forState:UIControlStateNormal];
                [button addTarget:self action:@selector(clickContinue:) forControlEvents:UIControlEventTouchUpInside];
                break;
            }
            case 1:
            {
                [button setTitle:@"查看" forState:UIControlStateNormal];
                [button addTarget:self action:@selector(clickShowPlayer:) forControlEvents:UIControlEventTouchUpInside];
                break;
            }
            case 2:
            {
                [button setTitle:@"设置" forState:UIControlStateNormal];
                [button addTarget:self action:@selector(clickSetting:) forControlEvents:UIControlEventTouchUpInside];
                break;
            }
            case 3:
            {
                [button setTitle:@"帮助" forState:UIControlStateNormal];
                [button addTarget:self action:@selector(clickHelp:) forControlEvents:UIControlEventTouchUpInside];
                break;
            }
            case 4:
            {
                [button setTitle:@"退出" forState:UIControlStateNormal];
                [button addTarget:self action:@selector(clickQuit:) forControlEvents:UIControlEventTouchUpInside];
                break;
            }
            default:
                break;
        }
        [self.mainMenuBarView addSubview:button];
        [button release];
    }
}

- (void)show
{
    if (_currentViewController) {
        if (self.mainMenuButton.hidden == NO) {
            [self addButtonToMainMenuBarView];
            [_currentViewController.view addSubview:self.mainMenuBarView];
        }
        
        [self.nextButton addTarget:self action:@selector(clickNextButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.previousButton addTarget:self action:@selector(clickPrivousButton:) forControlEvents:UIControlEventTouchUpInside]; 
        [self.mainMenuButton addTarget:self action:@selector(clickMainMenuButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.tipsButton addTarget:self action:@selector(clickTipsButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.mainMenuButton];
        [self addSubview:self.previousButton];
        [self addSubview:self.nextButton];
        [self addSubview:self.tipsButton];
        [_currentViewController.view addSubview:self];
        
        self.status = CLOSED;
    }
}


@end
