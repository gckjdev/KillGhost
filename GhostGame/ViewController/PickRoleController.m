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
        [_playerCardManager createCardsFromGame:aGame];
        [[PlayerCardManager showCardManager] createCardsFromPlayerList:
         _playerCardManager.playerList];
    }
    return self;
}

- (void)dealloc
{
    [_mainMenuBarView release];
    [_mainMenuButton release];
    [super dealloc];
}

- (void)addPlayerCardViews
{
    for (PlayerCard *card in _playerCardManager.playerCardList) {
        if (card.status != DEAD) {
            card.status = WILLSHOW;
        }
        [self.view addSubview:card];
    }
}

- (IBAction)clickNextButton:(id)sender {
    StateController *sc = [[StateController alloc] init];
    sc.operationTipsArray = [NSArray arrayWithObjects:@"1.法官宣布:所有玩家闭眼。\n\n\n\n(所有玩家闭眼后，则进入下一步)",@"2.法官宣布:鬼睁开眼,并且商量谁第一个发言。\n\n\n(鬼商量之后,则进入下一步)",@"3.法官宣布:鬼闭眼。\n\n\n\n(所有鬼闭眼后，则进入下一步)",@"4.法官宣布:所有玩家睁眼。\n\n\n\n(所有玩家睁开眼后，则进入下一步)",@"5.法官指定第一个发言者，按顺序开始描述。\n\n\n\n(直到全部玩家描述完毕，则进入下一步)",@"6.法官宣布:进入投票阶段。", nil];
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



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addPlayerCardViews];
    self.mainMenuBarView.frame = (CGRect){CGPointMake(0, 430), self.mainMenuBarView.frame.size};
}

- (void)viewDidUnload
{
    [self setMainMenuBarView:nil];
    [self setMainMenuButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

@end
