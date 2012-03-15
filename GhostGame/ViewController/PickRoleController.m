//
//  PlayGameController.m
//  GhostGame
//
//  Created by gamy on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "PickRoleController.h"
#import "Game.h"
#import "Player.h"
#import "StateController.h"
#import "PlayerCardManager.h"
#import "SettingsController.h"
#import "HelpController.h"

@implementation PickRoleController
@synthesize game = _game;
@synthesize mainMenuBarView = _mainMenuBarView;
@synthesize mainMenuButton = _mainMenuButton;
@synthesize controllerTitle = _controllerTitle;
@synthesize footerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (id)initWithGame:(Game *)aGame
{
    self = [super init];
    if (self) {
        self.game = aGame;
        _playerCardManager = [PlayerCardManager defaultManager];
        [_playerCardManager createUncertainCardsWithGame:aGame];
//        [[PlayerCardManager showCardManager] createUncertainCardsWithGame:aGame];
    }
    return self;
}

- (void)dealloc
{
    [_mainMenuBarView release];
    [_mainMenuButton release];
    [_controllerTitle release];
    [footerView release];
    [super dealloc];
}

- (void)addPlayerCardViews
{
    for (PlayerCard *card in _playerCardManager.playerCardList) {
        if (card.status != DEAD) {
            card.status = UNCERTAIN;
        }
        [self.view addSubview:card];
    }
}

- (IBAction)clickBackButton:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
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
    self.footerView.tips = @"法官先确定自己的位置，从法官的下一位开始将手机按顺序传给每个玩家，玩家点击查看各自的牌，最终将手机交会给法官。";
    self.footerView.nextButton.hidden = YES;
    [self.footerView.nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView show];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addPlayerCardViews];
    [self.controllerTitle setText:@"确定法官位置"];
    [[PlayerCardManager defaultManager] setPickRoleDelegate:self];
    
    [self showFooter];
}

- (void)viewDidUnload
{
    [self setMainMenuBarView:nil];
    [self setMainMenuButton:nil];
    [self setControllerTitle:nil];
    [self setFooterView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Pick Role delegate
- (void)didPickedJudge:(PlayerCard *)Judge
{
    if (Judge) {
        [self.controllerTitle setText:@"确定身份"];
    }
}

- (void)didpickedplayercard:(PlayerCard *)playerCard
{
    self.footerView.previousButton.hidden = YES;
    if ([[PlayerCardManager defaultManager] isAllCardsShow]) {
        self.footerView.nextButton.hidden = NO;
    }
}

- (void)nextAction:(id)sender
{
    StateController *sc = [[StateController alloc] init];
    
    sc.toSayArray = [NSArray arrayWithObjects:
                     @"法官宣布: 天黑,请闭眼。",
                     @"法官宣布: 鬼睁开眼,商量并且指定谁第一个发言",
                     @"法官宣布: 鬼闭眼。",
                     @"法官宣布: 天亮,所有玩家睁眼。",
                     @"法官指定第一个发言者,按顺序开始陈述。",
                     @"法官宣布: 进入投票阶段。",
                     nil];
    
    
    sc.explainArray = [NSArray arrayWithObjects:
                       @"(玩家闭眼后,则点击下一步)", 
                       @"(鬼指定之后,则点击下一步)",
                       @"(鬼闭眼后,则点击下一步)",
                       @"(玩家睁开眼后,则点击下一步)",
                       @"(直到全部玩家描述完毕,则点击下一步)",
                       @"(宣布完即可点击下一步)",
                       nil];
    
    sc.tipsArray = [NSArray arrayWithObjects:
                    @"确保所有玩家都闭眼哦", 
                    @"鬼之间用眼神或手势交流，并且用手势告诉法官谁第一个发言",
                    @"确保所有玩家都闭眼哦",
                    @"大家睁开眼，即将进入激烈的博弈",
                    @"发言内容是描述各自看到的词语，平民的发言尽量让其他平民知道自己是平民，同时不要让鬼猜出词语，鬼的发言尽量让平民以为自己是平民。",
                    @"宣布进入投票后即可点击下一步",
                    nil];
    [self.navigationController pushViewController:sc animated:YES];
    [sc release];
}

@end
