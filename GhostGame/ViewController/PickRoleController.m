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
#import "PlayerCard.h"
#import "StateController.h"

@implementation PickRoleController
@synthesize game = _game;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _playerList = [[NSMutableArray alloc] init];
        _cardList = [[NSMutableArray alloc] init];
        _pickIndex = - 1;
    }
    return self;
}

- (IBAction)clickNextButton:(id)sender {
    StateController *sc = [[StateController alloc] init];
    [self.navigationController pushViewController:sc animated:YES];
    [sc release];
}

- (id)initWithGame:(Game *)aGame
{
    self = [super init];
    if (self) {
        self.game = aGame;
    }
    return self;
}

- (void)dealloc
{
    [_playerList release];
    [_cardList release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)createPlayerList
{
    [_playerList removeAllObjects];
    srand(time(0));
    if (_game) {
        NSInteger count = _game.foolNumber + _game.ghostNumber + _game.civilianNumber;
        NSInteger total = count;
        NSInteger fCount = _game.foolNumber;
        NSInteger gCount = _game.ghostNumber;
        NSInteger cCount = _game.civilianNumber;
        for (int i = 0; i < count; ++ i) {
            Player *player = nil;
            int r = rand() % total;
            if (r < fCount) {
                //fool
                player = [[Player alloc] initWithType:FoolType word:_game.foolWord alive:YES];
                fCount -- ;
            }else if( r < fCount + gCount){
                //ghost
                player = [[Player alloc] initWithType:GhostType word:_game.ghostWord alive:YES];
                gCount --;
            }else{
                //civilian
                player = [[Player alloc] 
                          initWithType:CivilianType word:_game.civilianWord alive:YES];
                cCount --;
            }
            total --;
            [_playerList addObject:player];
            [player release];
        }
    }
}
- (void)createCards
{
    //NSInteger count = _game.civilianNumber + _game.foolNumber + _game.ghostNumber;
    //NSInteger count = 8;
    [_cardList removeAllObjects];
    [self createPlayerList];
    NSInteger i = 0;
    NSInteger count = [_playerList count];
    for (Player *player in _playerList) {
        CGPoint center = CGPointMake(cosf(M_PI * 2.0 * i / count - M_PI_2) * 128 + 160, sinf(M_PI * 2.0 / count * i - M_PI_2) * 160 + 200);
        PlayerCard *card = [[PlayerCard alloc] initWithPlayer:player position:center];
        card.delegate = self;
        [self.view addSubview:card];
        [_cardList addObject:card];
        [card release];
        ++ i;
    }
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createCards];
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


- (void)willClickPlayerCard:(PlayerCard *)playerCard
{
    if (playerCard) {
        if (index < 0) {
            return;
        }
        if (playerCard.status == UNSHOW) {
            //first show
            
        }else if(playerCard.status == SHOWED){
            //need password
            
        }
    }
}

- (BOOL)respondsToClickPlayerCard:(PlayerCard *)playerCard
{
    if (playerCard) {
        if (playerCard.status == SHOWING || playerCard.status == SHOWED) {
            return YES;
        }
        NSInteger index = [_cardList indexOfObject:playerCard];
        if (index < 0) {
            return NO;
        }
        if (_pickIndex == -1 || (_pickIndex + 1) % [_cardList count] == index) {
            _pickIndex = index;
            return YES;
        }
    }
    return NO;
}
- (void)didClickedPlayerCard:(PlayerCard *)playerCard
{

}

@end
