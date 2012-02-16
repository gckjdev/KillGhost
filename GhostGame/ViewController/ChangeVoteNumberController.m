//
//  ChangeVoteNumberController.m
//  GhostGame
//
//  Created by haodong qiu on 12年2月15日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "ChangeVoteNumberController.h"
#import "PlayerCard.h"
#import "PlayerCardManager.h"

@implementation ChangeVoteNumberController
@synthesize voteNumberLabel;
@synthesize playerCard;
@synthesize minusOneButton;
@synthesize plusOneButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPlayerCard:(PlayerCard *)playerCardValue
{
    self = [super init];
    if (self ) {
        self.playerCard = playerCardValue;
    }
    return self;
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
    // Do any additional setup after loading the view from its nib.
    [self updateVoteNumberLabel];
}

- (void)viewDidUnload
{
    [self setVoteNumberLabel:nil];
    [self setPlayerCard:nil];
    [self setMinusOneButton:nil];
    [self setPlusOneButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [voteNumberLabel release];
    [playerCard release];
    [minusOneButton release];
    [plusOneButton release];
    [super dealloc];
}

- (IBAction)plusOne:(id)sender
{
    self.playerCard.voteNumber++;
    [self updateVoteNumberLabel];
    [self updateButtonStatus];
}

- (IBAction)minusOne:(id)sender
{
    if (self.playerCard.voteNumber == 0) {
        return;
    }
    self.playerCard.voteNumber--;
    [self updateVoteNumberLabel];
    [self updateButtonStatus];
}

- (void)updateButtonStatus
{
    if (self.playerCard.voteNumber == 0) 
        self.minusOneButton.enabled = NO;
    else
        self.minusOneButton.enabled = YES;
    
    int allVoteCount = 0, hasVoteCount = 0;
    for (PlayerCard *card in [[PlayerCardManager defaultManager] playerCardList ]) {
        if (card.status != DEAD)
        {
            allVoteCount ++;
            hasVoteCount += card.voteNumber;
        }
    }
    
    if (self.playerCard.voteNumber == allVoteCount - 1 || self.playerCard.voteNumber == allVoteCount - hasVoteCount) {
        self.plusOneButton.enabled = NO;
    }
    else
    {
        self.plusOneButton.enabled = YES;
    }
    
}

- (void)updateVoteNumberLabel
{
    self.voteNumberLabel.text = [NSString stringWithFormat:@"%d", self.playerCard.voteNumber];
}


@end
