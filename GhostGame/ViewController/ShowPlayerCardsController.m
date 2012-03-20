//
//  ShowPlayerCardsController.m
//  GhostGame
//
//  Created by  on 12-2-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShowPlayerCardsController.h"
#import "PlayerCardManager.h"
#import "PlayerCard.h"
#import "LocaleUtils.h"

@implementation ShowPlayerCardsController
@synthesize viewTitleLabel;
@synthesize backLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)addPlayerCards
{
    PlayerCardManager *manager = [PlayerCardManager defaultManager];
    for (PlayerCard *card in manager.playerCardList) {
        PlayerCard *showCard = [[PlayerCard alloc] initWithPlayer:card.player position:card.position showIngindex:card.index status:EXAMINE];
//        showCard.status = EXAMINE;
        [self.view addSubview:showCard];
        [showCard release];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewTitleLabel.text = NSLS(@"kShowIdentity");
    self.backLabel.text = NSLS(@"kBack");
    
    [self addPlayerCards];
}

- (void)viewDidUnload
{
    [self setViewTitleLabel:nil];
    [self setBackLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)clickBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    [viewTitleLabel release];
    [backLabel release];
    [super dealloc];
}
@end
