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
#import "StateController.h"

@implementation ResultController
@synthesize resultDescriptionLabel;
@synthesize promptLabel;
@synthesize guessRightButton;
@synthesize guessWrongButton;
@synthesize continueGameButton;
@synthesize finishButton;
@synthesize currentPlayerCard;
@synthesize result;
@synthesize winnerImageView;
@synthesize lightImageView;
@synthesize lightIndex;
@synthesize continueImageView;
@synthesize continueLabel;


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

- (void)lightAnimation
{
    lightIndex = 0;
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeLight) userInfo:nil repeats:YES];
}

- (void)changeLight
{
    lightIndex++;
    lightIndex = lightIndex % 3;
    
    if (lightIndex == 0) {
        self.lightImageView.image = [UIImage imageNamed:@"light_1@2x.png"];
    }
    else if (lightIndex == 1){
        self.lightImageView.image = [UIImage imageNamed:@"light_2@2x.png"];
    }
    else{
        self.lightImageView.image = [UIImage imageNamed:@"light_3@2x.png"];
    }
}

- (void)hideButton
{
    self.guessRightButton.hidden = YES;
    self.guessWrongButton.hidden = YES;
    self.continueGameButton.hidden = YES;
    self.finishButton.hidden = YES;
    self.continueLabel.hidden = YES;
    self.continueImageView.hidden = YES;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self hideButton];
    
    self.resultDescriptionLabel.frame = CGRectMake(20, 240, 220, 40);
    self.promptLabel.frame = CGRectMake(20, 280, 220, 60);
    self.promptLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.promptLabel.numberOfLines = 0;
        
    if (self.currentPlayerCard.player.type == GhostType ) {
        self.resultDescriptionLabel.text = @"此玩家是鬼,请猜词";
        self.promptLabel.text = @"提示:法官根据鬼说的词语,判断猜对或猜错";
        self.guessRightButton.hidden = NO;
        self.guessWrongButton.hidden = NO;
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
    [self hideButton];
    
    //游戏继续
    if (result == ResultContinue) { 
        self.resultDescriptionLabel.text = @"游戏继续";
        
        //游戏继续有两个理由
        if (self.currentPlayerCard.player.type == GhostType) {
            self.promptLabel.text = @"理由:鬼没有猜对词语";
        }
        else
        {
            self.promptLabel.text = @"理由:此玩家不是鬼";
        }
        
        self.continueGameButton.hidden = NO;
        self.continueLabel.hidden = NO;
        self.continueImageView.hidden = NO;
    }
    //游戏结束
    else  
    {
        UIImageView *wiv = [[UIImageView alloc] initWithFrame:CGRectMake((320-255)/2, 80, 255, 353)];
        self.winnerImageView = wiv;
        [wiv release];
        [self.winnerImageView addSubview:self.resultDescriptionLabel];
        [self.winnerImageView addSubview:self.promptLabel];
        [self.view addSubview:self.winnerImageView];
        
        if (result == ResultGhostWin) 
        {
            self.winnerImageView.image = [UIImage imageNamed:@"ghost_win@2x.png"];
            self.resultDescriptionLabel.text = @"游戏结束,鬼胜出！";
            //鬼胜出有两个理由
            if (self.currentPlayerCard.player.type == GhostType) 
                self.promptLabel.text = @"理由:鬼猜对了词语";
            else
                self.promptLabel.text = @"理由:被错杀的数量等于鬼的总数量";
        }
        else if (result == ResultCivilianWin)
        {
            self.winnerImageView.image = [UIImage imageNamed:@"civilian_win@2x.png"];
            self.resultDescriptionLabel.text = @"游戏结束,平民胜出！";
            self.promptLabel.text = @"理由:所有的鬼已被杀死";
        }
        
        self.finishButton.hidden = NO;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 442)];
        self.lightImageView = imageView;
        [imageView release];
        [self.view addSubview:self.lightImageView];
        [self lightAnimation];
    }

}

- (void)viewDidUnload
{
    [self setResultDescriptionLabel:nil];
    [self setPromptLabel:nil];
    [self setGuessRightButton:nil];
    [self setGuessWrongButton:nil];
    [self setCurrentPlayerCard:nil];
    [self setContinueGameButton:nil];
    [self setFinishButton:nil];
    [self setLightImageView:nil];
    [self setContinueImageView:nil];
    [self setContinueLabel:nil];
    [super viewDidUnload];
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
    [continueGameButton release];
    [finishButton release];
    [lightImageView release];
    [continueImageView release];
    [continueLabel release];
    [super dealloc];
}

- (IBAction)clickGuessRightButton:(id)sender
{
    self.result = ResultGhostWin;
    [self showResult];
}

- (IBAction)clickGuessWrongButton:(id)sender
{
    self.result = [ResultManager resultByOut:[PlayerCardManager defaultManager]];
    [self showResult];
}

- (IBAction)continueGame:(id)sender
{
    StateController *sc = [[StateController alloc] init];
    sc.operationTipsArray = [NSArray arrayWithObjects:@"法官宣布:由出局者的下一位玩家，按顺序开始描述。\n\n(直到全部玩家描述完毕，则进入下一步)",@"法官宣布:进入投票阶段。", nil];
    [self.navigationController pushViewController:sc animated:YES];
    [sc release];
}

- (IBAction)clickFinishButton:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
