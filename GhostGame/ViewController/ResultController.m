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

@implementation ResultController
@synthesize resultDescriptionLabel;
@synthesize promptLabel;
@synthesize guessRightButton;
@synthesize guessWrongButton;

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.resultDescriptionLabel.text = nil;
    self.promptLabel.text = nil;
    self.guessRightButton.hidden = YES;
    self.guessWrongButton.hidden = YES;
    
    NSInteger result = [ResultManager resultByOut:[PlayerCardManager defaultManager]];
    if (result == ResultContinue) {
        self.resultDescriptionLabel.text = @"游戏继续";
    }
    else if (result == ResultGhostWin) {
        self.resultDescriptionLabel.text = @"游戏结束,鬼胜出！";
    }
    else if (result == ResultCivilianWin) {
        //猜词
        self.resultDescriptionLabel.text = @"请鬼猜词";
        
        self.promptLabel.text = @"如果猜对后请按'猜对',如果猜错后按'猜错'";
        
        self.guessRightButton.hidden = NO;
        self.guessWrongButton.hidden = NO;
    }
}

- (void)viewDidUnload
{
    [self setResultDescriptionLabel:nil];
    [self setPromptLabel:nil];
    [self setGuessRightButton:nil];
    [self setGuessWrongButton:nil];
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
    [super dealloc];
}

- (IBAction)clickGuessRightButton:(id)sender
{
    self.resultDescriptionLabel.text =  @"游戏结束,鬼胜出！";
    
    self.promptLabel.text = nil;
}

- (IBAction)clickGuessWrongButton:(id)sender
{
    self.resultDescriptionLabel.text = @"游戏结束,平民胜出！";
    
    self.promptLabel.text = nil;
}


@end
