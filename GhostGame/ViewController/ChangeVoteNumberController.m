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
@synthesize cardIndexImageView;

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

- (void)setCardImage{
    UIImage *image = nil;
    switch (playerCard.index) {
        case 1:
            image = [UIImage imageNamed:@"vote_number_1@2x.png"];
            break;
        case 2:
            image = [UIImage imageNamed:@"vote_number_2@2x.png"];
            break;
        case 3:
            image = [UIImage imageNamed:@"vote_number_3@2x.png"];
            break;
        case 4:
            image = [UIImage imageNamed:@"vote_number_4@2x.png"];
            break;
        case 5:
            image = [UIImage imageNamed:@"vote_number_5@2x.png"];
            break;
        case 6:
            image = [UIImage imageNamed:@"vote_number_6@2x.png"];
            break;
        case 7:
            image = [UIImage imageNamed:@"vote_number_7@2x.png"];
            break;
        case 8:
            image = [UIImage imageNamed:@"vote_number_8@2x.png"];
            break;
        case 9:
            image = [UIImage imageNamed:@"vote_number_9@2x.png"];
            break;
        case 10:
            image = [UIImage imageNamed:@"vote_number_10@2x.png"];
            break;
        case 11:
            image = [UIImage imageNamed:@"vote_number_11@2x.png"];
            break;
        case 12:
            image = [UIImage imageNamed:@"vote_number_12@2x.png"];
            break;
        case 13:
            image = [UIImage imageNamed:@"vote_number_13@2x.png"];
            break;
        default:
            break;
    }
    self.cardIndexImageView.image = image;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self updateVoteNumberLabel];
    [self setCardImage];
}

- (void)viewDidUnload
{
    [self setVoteNumberLabel:nil];
    [self setPlayerCard:nil];
    [self setMinusOneButton:nil];
    [self setPlusOneButton:nil];
    [self setCardIndexImageView:nil];
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
    [cardIndexImageView release];
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
