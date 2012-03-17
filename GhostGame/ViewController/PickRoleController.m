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
#import "LocaleUtils.h"

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
    self.footerView.tips = NSLS(@"kTips2");
    self.footerView.nextButton.hidden = YES;
    [self.footerView.nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView show];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addPlayerCardViews];
    [self.controllerTitle setText:NSLS(@"kSelectJudgePosition")];
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

#define BACKVIEW_TAG 1000
- (void)addBackView
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.5;
    backView.tag = BACKVIEW_TAG;
    [self.view addSubview:backView];
    [backView release];
}

- (void)cancelBackView
{
    UIView *view = [self.view viewWithTag:BACKVIEW_TAG];
    [view removeFromSuperview];
}

#pragma mark - Pick Role delegate


- (void)willPickplayercard:(PlayerCard *)playerCard
{
    [self addBackView];
}

- (void)didPickedJudge:(PlayerCard *)Judge
{
    self.footerView.previousButton.hidden = YES;
    if (Judge) {
        [self.controllerTitle setText:NSLS(@"kDetermineIdentity")];
    }
}

- (void)didpickedplayercard:(PlayerCard *)playerCard
{
    [self cancelBackView];
    if ([[PlayerCardManager defaultManager] isAllCardsShow]) {
        self.footerView.nextButton.hidden = NO;
    }
}

- (void)nextAction:(id)sender
{
    StateController *sc = [[StateController alloc] init];
    
    sc.toSayArray = [NSArray arrayWithObjects:
                     NSLS(@"kJudgeDeclared1"),
                     NSLS(@"kJudgeDeclared2"),
                     NSLS(@"kJudgeDeclared3"),
                     NSLS(@"kJudgeDeclared4"),
                     NSLS(@"kJudgeDeclared5"),
                     NSLS(@"kJudgeDeclared6"),
                     nil];
    
    sc.explainArray = [NSArray arrayWithObjects:
                       NSLS(@"kExplain1"),
                       NSLS(@"kExplain2"),
                       NSLS(@"kExplain3"),
                       NSLS(@"kExplain4"),
                       NSLS(@"kExplain5"),
                       NSLS(@"kExplain6"),
                       nil];
    
    sc.tipsArray = [NSArray arrayWithObjects:
                    NSLS(@"kTips3"),
                    NSLS(@"kTips4"),
                    NSLS(@"kTips5"),
                    NSLS(@"kTips6"),
                    NSLS(@"kTips7"),
                    NSLS(@"kTips8"),
                    nil];
    
    [self.navigationController pushViewController:sc animated:YES];
    [sc release];
}

@end
