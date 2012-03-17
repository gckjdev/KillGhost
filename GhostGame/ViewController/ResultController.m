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
#import "LocaleUtils.h"

@implementation ResultController
@synthesize guessRightButton;
@synthesize guessWrongButton;
@synthesize quitButton;
@synthesize againButton;
@synthesize currentPlayerCard;
@synthesize result;
@synthesize lightImageView;
@synthesize lightIndex;
@synthesize footerView;
@synthesize dialogView;

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
}

- (void)addButton
{
    self.guessWrongButton = [self createButton:@"wrong.png" text:NSLS(@"kWrong") position:40 ];
    [self.guessWrongButton  addTarget:self action:@selector(clickGuessWrongButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.guessWrongButton];
    
    self.guessRightButton = [self createButton:@"right.png" text:NSLS(@"kRight") position:200 ];
    [self.guessRightButton addTarget:self action:@selector(clickGuessRightButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.guessRightButton];
    
    self.quitButton =  [self createButton:@"not_again.png" text:NSLS(@"kQuitGame") position:40];
    [self.quitButton addTarget:self action:@selector(clickQuitButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.quitButton];
    
    self.againButton =  [self createButton:@"again.png" text:NSLS(@"kAgain") position:200 ];
    [self.againButton addTarget:self action:@selector(clickAgainButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.againButton];
}

- (void)showFooter
{
    FooterView *fv = [[FooterView alloc] init];
    self.footerView = fv;
    [fv release];
    
    self.footerView.currentViewController = self;
    [self.footerView.nextButton addTarget:self action:@selector(continueGame:) forControlEvents:UIControlEventTouchUpInside];
    self.footerView.previousButton.hidden = YES;
    [self.footerView show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    DialogView *dv = [[DialogView alloc] init];
    self.dialogView = dv;
    [dv release];
    [self.view addSubview:self.dialogView];
    
    [self addButton];
    [self hideButton];
        
    if (self.currentPlayerCard.player.type == GhostType ) {
        self.dialogView.toSay.text = NSLS(@"kGuessWord") ;
        self.dialogView.explain.text = NSLS(@"kPressRightOrWrong");
        
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
    [self hideButton];
    
    //游戏继续
    if (result == ResultContinue) { 
        [self showFooter];
        
        //游戏继续有两个理由
        if (self.currentPlayerCard.player.type == GhostType) {
            self.dialogView.toSay.text = NSLS(@"kGhostGuessGuessWrong");
            self.dialogView.explain.text = NSLS(@"kClickNext");
            self.footerView.tips = NSLS(@"kClickNext");
        }
        else
        {
            self.dialogView.toSay.text = NSLS(@"kNotGhost");
            self.dialogView.explain.text = NSLS(@"kClickNext");
            self.footerView.tips = NSLS(@"kNotGhostAndContinue");
        }
    }
    //游戏结束
    else  
    {
        [self.dialogView removeFromSuperview];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((320-255)/2, 80, 255, 353)];
        UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 250, 220, 40)];
        resultLabel.lineBreakMode = UILineBreakModeWordWrap;
        resultLabel.numberOfLines = 0;
        resultLabel.font = [UIFont boldSystemFontOfSize:22];
        resultLabel.backgroundColor = [UIColor clearColor];
        resultLabel.textAlignment = UITextAlignmentCenter;
        
        UILabel *reasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 280, 220, 60)];
        reasonLabel.lineBreakMode = UILineBreakModeWordWrap;
        reasonLabel.numberOfLines = 0;
        reasonLabel.font = [UIFont systemFontOfSize:14];
        reasonLabel.backgroundColor = [UIColor clearColor];
        reasonLabel.textAlignment = UITextAlignmentCenter;
        
        if (result == ResultGhostWin) 
        {
            imageView.image = [UIImage imageNamed:@"ghost_win@2x.png"];
            resultLabel.text = NSLS(@"kGhostWin");
            //鬼胜出有两个理由
            if (self.currentPlayerCard.player.type == GhostType) 
                reasonLabel.text = NSLS(@"kGhostGuessRight");
            else
                reasonLabel.text = @"理由:被错杀的数量等于鬼的总数量";
        }
        else if (result == ResultCivilianWin)
        {
            imageView.image = [UIImage imageNamed:@"civilian_win@2x.png"];
            resultLabel.text = @"游戏结束,平民胜出!";
            reasonLabel.text = @"理由:所有的鬼已被杀死";
        }
        [imageView addSubview:resultLabel];
        [resultLabel release];
        [imageView addSubview:reasonLabel];
        [reasonLabel release];
        [self.view addSubview:imageView];
        [imageView release];
        
        self.againButton.hidden = NO;
        self.quitButton.hidden = NO;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 442)];
        self.lightImageView = iv;
        [iv release];
        [self.view addSubview:self.lightImageView];
        [self lightAnimation];
    }

}

- (void)viewDidUnload
{
    //[self setResultDescriptionLabel:nil];
    //[self setPromptLabel:nil];
    [self setGuessRightButton:nil];
    [self setGuessWrongButton:nil];
    [self setCurrentPlayerCard:nil];
    [self setQuitButton:nil];
    [self setAgainButton:nil];
    [self setLightImageView:nil];
    //[self setDialogBoxImageView:nil];
    [self setFooterView:nil];
    [self setDialogView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    //[resultDescriptionLabel release];
    //[promptLabel release];
    [guessRightButton release];
    [guessWrongButton release];
    [currentPlayerCard release];
    [quitButton release];
    [againButton release];
    [lightImageView release];
    //[dialogBoxImageView release];
    [footerView release];
    [dialogView release];
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

- (void)continueGame:(id)sender
{
    StateController *sc = [[StateController alloc] init];
    sc.toSayArray = [NSArray arrayWithObjects:
                     @"法官宣布: 由出局者的下一位玩家,按顺序开始陈述。",
                     @"法官宣布: 进入投票阶段。",
                     nil];
    
    sc.explainArray = [NSArray arrayWithObjects:
                       @"(直到全部玩家陈述完毕，则点击下一步)", 
                       @"(宣布完即可点击下一步)",
                       nil];
    
    sc.tipsArray = [NSArray arrayWithObjects:
                    @"这是一轮新的描述,继续展开紧张的博弈吧",
                    @"宣布进入投票后即可点击下一步",
                    nil];
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
