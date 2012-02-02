//
//  PlayGameController.m
//  GhostGame
//
//  Created by gamy on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "PickRoleController.h"
#import "Game.h"

@implementation PickRoleController
@synthesize game = _game;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _playerList = [[NSMutableArray alloc] init];
        _cardList = [[NSMutableArray alloc] init];
    }
    return self;
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
            int r = rand() % total;
            if (r < fCount) {
                //fool
                fCount -- ;
            }else if( r < fCount + gCount){
                //ghost
                gCount --;
            }else{
                //civilian
                cCount --;
            }
            total --;
        }
    }
}
- (void)createSeats
{
    //NSInteger count = _game.civilianNumber + _game.foolNumber + _game.ghostNumber;
    NSInteger count = 8;
    for (int i = 0; i < count; ++ i) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"12" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickCard) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 50, 50);
        CGPoint center = CGPointMake(cosf(M_PI * 2.0 * i / count) * 120 + 160, sinf(M_PI * 2.0 / count * i) * 160 + 200);
        button.center = center;
        [self.view addSubview:button];
        
    }
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createSeats];
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
