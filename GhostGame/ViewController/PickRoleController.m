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

- (IBAction)clickNextButton:(id)sender {
    StateController *sc = [[StateController alloc] init];
    sc.operationTipsArray = [NSArray arrayWithObjects:@"法官宣布:所有玩家闭眼。\n\n(所有玩家闭眼后，则进入下一步)",@"法官宣布:鬼睁开眼,并且商量谁第一个发言。\n\n(鬼商量之后,则进入下一步)",@"法官宣布:鬼闭眼。\n\n(所有鬼闭眼后，则进入下一步)",@"法官宣布:所有玩家睁眼。\n\n(所有玩家睁开眼后，则进入下一步)",@"法官指定第一个发言者，按顺序开始描述。\n\n(直到全部玩家描述完毕，则进入下一步)",@"法官宣布:进入投票阶段。", nil];
    [self.navigationController pushViewController:sc animated:YES];
    [sc release];
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
    StateController *sc = [[StateController alloc] init];
    sc.operationTipsArray = [NSArray arrayWithObjects:@"法官宣布:所有玩家闭眼。\n\n(所有玩家闭眼后，则进入下一步)",@"法官宣布:鬼睁开眼,并且商量谁第一个发言。\n\n(鬼商量之后,则进入下一步)",@"法官宣布:鬼闭眼。\n\n(所有鬼闭眼后，则进入下一步)",@"法官宣布:所有玩家睁眼。\n\n(所有玩家睁开眼后，则进入下一步)",@"法官指定第一个发言者，按顺序开始描述。\n\n(直到全部玩家描述完毕，则进入下一步)",@"法官宣布:进入投票阶段。", nil];
    self.footerView.nextViewController = sc;
    [sc release];
    self.footerView.tips = @"请将手机按顺序传给每个玩家，玩家点击查看各自的牌";
    //self.footerView.nextButton.hidden = YES;
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

@end
