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
#import "VoteController.h"

@implementation PickRoleController
@synthesize game = _game;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        _playerList = [[NSMutableArray alloc] init];

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
    }
    return self;
}

- (void)dealloc
{
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
    [self.navigationController pushViewController:sc animated:YES];
    [sc release];
//    VoteController *vc = [[VoteController alloc] initWithPlayerManager:_playerCardManager];
//    [self.navigationController pushViewController:vc animated:YES];
//    [vc release];
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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
