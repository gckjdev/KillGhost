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
#import "CreateNewGameController.h"

@implementation ResultController
@synthesize resultDescriptionLabel;
@synthesize promptLabel;
@synthesize guessRightButton;
@synthesize guessWrongButton;
@synthesize continueGameButton;
@synthesize quitButton;
@synthesize againButton;
@synthesize currentPlayerCard;
@synthesize result;
@synthesize winnerImageView;
@synthesize lightImageView;
@synthesize lightIndex;
@synthesize continueImageView;
@synthesize continueLabel;
@synthesize dialogBoxImageView;

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
        self.lightImageView.image = [UIImage imageNamed:@"light_1.png"];
    }
    else if (lightIndex == 1){
        self.lightImageView.image = [UIImage imageNamed:@"light_2.png"];
    }
    else{
        self.lightImageView.image = [UIImage imageNamed:@"light_3.png"];
    }
}

#pragma mark - View lifecycle

- (UIButton *)createButton:(NSString *)imageName text:(NSString *)text position:(CGFloat)x
{
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(x, 442, 100, 38)] autorelease];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    iv.frame= CGRectMake(0, (38-25)/2, 22, 25);
    [button addSubview:iv];
    [iv release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, 60, 38)];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor colorWithRed:0xF3/255.0 green:0xB1/255.0 blue:0x5B/255.0 alpha:1.0 ];
    label.backgroundColor = [UIColor clearColor];
    label.text =text;
    
    [button addSubview:label];
    [label release];
    return button;
}

- (void)hideButton
{
    self.guessRightButton.hidden = YES;
    self.guessWrongButton.hidden = YES;
    self.quitButton.hidden = YES;
    self.againButton.hidden = YES;
    self.continueGameButton.hidden = YES;
    self.continueLabel.hidden = YES;
    self.continueImageView.hidden = YES;
}

- (void)addButton
{
    
    self.guessWrongButton = [self createButton:@"wrong.png" text:@"猜错了" position:40 ];
    [self.guessWrongButton  addTarget:self action:@selector(clickGuessWrongButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.guessWrongButton];
    
    self.guessRightButton = [self createButton:@"right.png" text:@"猜对了" position:200 ];
    [self.guessRightButton addTarget:self action:@selector(clickGuessRightButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.guessRightButton];
    
    self.quitButton =  [self createButton:@"not_again.png" text:@"退出游戏" position:40];
    [self.quitButton addTarget:self action:@selector(clickQuitButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.quitButton];
    
    self.againButton =  [self createButton:@"again.png" text:@"再来一盘" position:200 ];
    [self.againButton addTarget:self action:@selector(clickAgainButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.againButton];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addButton];
    [self hideButton];
    
    self.resultDescriptionLabel.frame = CGRectMake(40-11, 40, 240, 40);
    self.promptLabel.frame = CGRectMake(40-11, 100, 220, 60);
    self.promptLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.promptLabel.numberOfLines = 0;
    
    UIImageView *dbv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dialog_box.png"]];
    dbv.frame = CGRectMake(11, 100, 297, 288);
    self.dialogBoxImageView = dbv;
    [dbv release];
    [self.dialogBoxImageView addSubview:self.resultDescriptionLabel];
    [self.dialogBoxImageView addSubview:self.promptLabel];
    [self.view addSubview:self.dialogBoxImageView];
        
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
        [self.dialogBoxImageView removeFromSuperview];
        
        self.resultDescriptionLabel.frame = CGRectMake(20, 240, 220, 40);
        self.promptLabel.frame = CGRectMake(20, 280, 220, 60);
        self.promptLabel.lineBreakMode = UILineBreakModeWordWrap;
        self.promptLabel.numberOfLines = 0;
        
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
        
        self.againButton.hidden = NO;
        self.quitButton.hidden = NO;
        
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
    [self setQuitButton:nil];
    [self setAgainButton:nil];
    [self setLightImageView:nil];
    [self setContinueImageView:nil];
    [self setContinueLabel:nil];
    [self setDialogBoxImageView:nil];
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
    [quitButton release];
    [againButton release];
    [lightImageView release];
    [continueImageView release];
    [continueLabel release];
    [dialogBoxImageView release];
    [super dealloc];
}

- (void)clickGuessRightButton
{
    self.result = ResultGhostWin;
    [self showResult];
}

- (void)clickGuessWrongButton
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

- (void)clickQuitButton
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)clickAgainButton
{
    CreateNewGameController *cngc = (CreateNewGameController *)[[self.navigationController viewControllers] objectAtIndex:1];
    cngc.wordLengthTextField.text =@"";
    cngc.foolWordTextField.text= @"";
    cngc.civilianWordTextField.text= @"";
    [self.navigationController popToViewController:cngc animated:YES];
}



@end
