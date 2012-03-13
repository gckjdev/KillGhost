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

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 480-40, 320, 40)];
    if (self) {
        
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

- (void)setStatus:(NSInteger)status
{
    _status = status;
    if (status == CLOSED) {
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

#pragma mark - action
- (void)clickContinue:(id)sender
{
    self.status = CLOSED;
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
    if (_status == CLOSED) {
        self.status = OPEN;
    }
    else {
        self.status = CLOSED;
    }
}

- (void)clickPrivousButton:(id)sender
{
    self.status = CLOSED;
    [_currentViewController.navigationController popViewControllerAnimated:YES];
}

- (void)clickNextButton:(id)sender
{
    self.status = CLOSED;
    [_currentViewController.navigationController pushViewController:_nextViewController animated:YES];
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
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 139, 270, 202)];
    imageView.image = [UIImage imageNamed:@"output_box.png"];
    imageView.userInteractionEnabled = YES;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(36, 34, 186, 118)];
    label.backgroundColor = [UIColor clearColor];
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
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(-2, self.frame.size.height-40, 82, 40)] autorelease];
    [button setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    
    return button;
}

- (UIButton *)createPreviousButton:(NSString *)previousButtonTitle
{
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(81, self.frame.size.height-38, 96, 38)] autorelease];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"previous.png"]];
    iv.frame= CGRectMake(0, 0, 36, 36);
    [button addSubview:iv];
    [iv release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 64, 38)];
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
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(240, self.frame.size.height-38, 80, 38)] autorelease];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next.png"]];
    iv.frame= CGRectMake(44, 0, 36, 36);
    [button addSubview:iv];
    [iv release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 38)];
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
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(180, self.frame.size.height-38, 38, 38)] autorelease];
    [button setImage:[UIImage imageNamed:@"bulb.png"] forState:UIControlStateNormal];
    return button;
}

- (UIView *)createMainMenuBarView
{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 230, 68, 230)] autorelease];
    
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

- (void)addButtonToMainMenuBarView
{
    UIButton *button = nil;
    for (int count= 0; count<5; count++) {
        button = [[UIButton alloc] initWithFrame:CGRectMake(0, 32+38*count, 68, 34)];
        [button setTitleColor:[UIColor colorWithRed:85/255.0 green:54/255.0 blue:24/255.0 alpha:1.0] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"button_bg_m.png"] forState:UIControlStateHighlighted];
        
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
        self.mainMenuBarView = [self createMainMenuBarView];
        self.mainMenuButton = [self createMainMenuButton];
        self.previousButton = [self createPreviousButton:@"上一步"];
        self.nextButton = [self createNextButton:@"下一步"];
        self.tipsButton = [self createTipsButton];
        [self addButtonToMainMenuBarView];
        [_currentViewController.view addSubview:self.mainMenuBarView];
        
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
