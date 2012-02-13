//
//  ResultController.m
//  GhostGame
//
//  Created by  on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ResultController.h"
#import "ResultManager.h"
#import "PlayerCardManager.h"
#import "PlayerCard.h"
#import "Player.h"

@implementation ResultController
@synthesize resultDescriptionLabel;
@synthesize promptLabel;
@synthesize guessRightButton;
@synthesize guessWrongButton;
@synthesize currentPlayerCard;
@synthesize result;
@synthesize isGuessRight;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCurrentPlayerCard:(PlayerCard *)currentPlayerCardValue;
{
    self = [super init];
    if (self ) {
        self.currentPlayerCard = currentPlayerCardValue;
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
    self.isGuessRight = NO;
        
    if (self.currentPlayerCard.player.type == GhostType ) {
        self.resultDescriptionLabel.text = @"此玩家是鬼,请猜词";
        self.promptLabel.text = @"提示:法官根据鬼说的词语,判断猜对或猜错";
    }
    else
    {
        self.result = [ResultManager resultByOut:[PlayerCardManager defaultManager]];
        [self showResult];
    }
}

- (void)showResult
{
    self.resultDescriptionLabel.text = nil;
    self.promptLabel.text = nil;
    self.guessRightButton.hidden = YES;
    self.guessWrongButton.hidden = YES;
    
    if (result == ResultContinue) {
        self.resultDescriptionLabel.text = @"游戏继续";
    }
    else if (result == ResultGhostWin) 
    {
        self.resultDescriptionLabel.text = @"游戏结束,鬼胜出！";
        
        //鬼胜出有两个理由
        if (isGuessRight) {
            self.promptLabel.text = @"理由:鬼猜对了词语";
        }
        else{
            self.promptLabel.text = @"理由:被杀死平民的数量等于鬼的总数量";
        }
        
    }
    else if (result == ResultCivilianWin)
    {
        self.resultDescriptionLabel.text = @"游戏结束,平民胜出！";
        self.promptLabel.text = @"理由:所有的鬼已被杀死";
    }
}

- (void)viewDidUnload
{
    [self setResultDescriptionLabel:nil];
    [self setPromptLabel:nil];
    [self setGuessRightButton:nil];
    [self setGuessWrongButton:nil];
    [self setCurrentPlayerCard:nil];
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
    [resultDescriptionLabel release];
    [promptLabel release];
    [guessRightButton release];
    [guessWrongButton release];
    [currentPlayerCard release];
    [super dealloc];
}

- (IBAction)clickGuessRightButton:(id)sender
{
    self.result = ResultGhostWin;
    self.isGuessRight = YES;
    [self showResult];
}

- (IBAction)clickGuessWrongButton:(id)sender
{
    self.result = [ResultManager resultByOut:[PlayerCardManager defaultManager]];
    [self showResult];
}


@end
