//
//  VoteController.m
//  GhostGame
//
//  Created by  on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VoteController.h"
//#import "PlayerCardManager.h"
#import "PlayerCard.h"
#import "LineSegment.h"
#import "LineSegmentView.h"
#import "ResultController.h"
#import "ChangeVoteNumberController.h"
#import "ShowPlayerCardsController.h"
#import "SettingsController.h"
#import "HelpController.h"

@implementation VoteController
@synthesize mainMenuBarView = _mainMenuBarView;
@synthesize mainMenuButton = _mainMenuButton;
@synthesize playerManager = _playerManager;
@synthesize lineViewArray = _lineViewArray;
@synthesize changeVoteNumberController;
@synthesize tipsController;
@synthesize willDeadPlayerCard;

#pragma mark - line segment

//- (void)constructLineSegments
//{
//    _lineViewArray = [[NSMutableArray alloc] init];
//    for (PlayerCard *card in self.playerManager.playerCardList) {
//        LineSegment *line = [[LineSegment alloc] init];
//        LineSegmentView *lineView = [[LineSegmentView alloc] initWithWithLineSegment:line];
//        [self.lineViewArray addObject:lineView];
//        [self.view addSubview:lineView];
//        [line release];
//        [lineView release];
//    }
//}
//
//- (LineSegmentView *)lineSegmentForPlayerCard:(PlayerCard *)card
//{
//    NSInteger index = [_playerManager indexOfPlayerCard:card];
//    if (index >= 0) {
//        return [_lineViewArray objectAtIndex:index];
//    }
//    return nil;
//}
//
//- (PlayerCard *)playerCardForLineSegmentView:(LineSegmentView *)lineSegmentView
//{
//    NSInteger index = [_lineViewArray indexOfObject:lineSegmentView];
//    if (index >= 0) {
//        return [_playerManager playerCardAtIndex:index];
//    }
//    return nil;
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.playerManager = [PlayerCardManager defaultManager];
//        [self constructLineSegments];
    }
    return self;
}



- (id)init
{
    self = [super init];
    if(self){
        self.playerManager = [PlayerCardManager defaultManager];
    }
    return self;
}


- (id)initWithPlayerManager:(PlayerCardManager *)manager
{
    self = [super init];
    if(self){
        self.playerManager = manager;    
    }
    return self;
}

- (void)dealloc
{
    [_playerManager release];
    [changeVoteNumberController release];
    [_mainMenuBarView release];
    [_mainMenuButton release];
    [tipsController release];
    [willDeadPlayerCard release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//- (BOOL)isPoint:(CGPoint)point insideRect:(CGRect)rect
//{
//    if (point.x < rect.origin.x || point.y < rect.origin.y) {
//        return NO;
//    }
//    if (point.x > rect.origin.x + rect.size.width || 
//        point.y > rect.origin.y + rect.size.height) {
//        return NO;
//    }
//    return YES;
//}
//
//- (PlayerCard *)playCardBeenTouchAtPoint:(CGPoint)point
//{
//    for(PlayerCard *card in _playerManager.playerCardList)
//    {
//        if ([self isPoint:point insideRect:card.frame]) {
//            return card;
//        }
//    }
//    return nil;
//}
//
//
//
//- (void)performPan:(UIPanGestureRecognizer *)pan
//{
//    CGPoint location = [pan locationInView:self.view];
//    if (pan.state == UIGestureRecognizerStateBegan) {
//        //card 
//        PlayerCard *card = [self playCardBeenTouchAtPoint:location];
//        if (card && card.status == VOTE) {
//            _isStartInCard = YES;
//            _currentVoteLine = [self lineSegmentForPlayerCard:card];
//            [_currentVoteLine setColor:[UIColor greenColor]];
//            [_currentVoteLine setStartPoint:card.center endPoint:card.center];
//            [_voteLine release];
//            
//        }else{
//            _isStartInCard = NO;
//            _currentVoteLine = nil;
//        }
//
//    }else if(pan.state == UIGestureRecognizerStateChanged){
//        if (_isStartInCard) {
//            PlayerCard *card = [self playCardBeenTouchAtPoint:location];
//            if (card && card.status == VOTE) {
//                [_currentVoteLine setColor:[UIColor yellowColor]];
//            }else{
//                [_currentVoteLine setColor:[UIColor greenColor]];
//            }
//            [_currentVoteLine setStartPoint:_currentVoteLine.startPoint endPoint:location];
//            
//        }
//        
//        
//    }else if(pan.state == UIGestureRecognizerStateEnded)
//    {
//        PlayerCard *card = [self playCardBeenTouchAtPoint:location];
//        if (card && card.status == VOTE) {
//            _isEndInCard = YES;
//        }else
//        {
//            _isEndInCard = NO;
//        }
//        if (_isStartInCard) {
//            PlayerCard *voteCard = [self playerCardForLineSegmentView:_currentVoteLine];
//            PlayerCard *preVotedCard = voteCard.voteForPlayer;
//            if (preVotedCard) {
//                preVotedCard.voteNumber --;
//            }
//            
//            if (_isEndInCard) {
//                [_currentVoteLine setStartPoint:_currentVoteLine.startPoint endPoint:card.center];
//                [_currentVoteLine setColor:[UIColor redColor]];
//                voteCard.voteForPlayer = card;
//                card.voteNumber ++;
//            }else{
//                voteCard.voteForPlayer = nil;
//                [_currentVoteLine setStartPoint:card.center endPoint:card.center];
//            }
//        }else{
//            
//        }
//        
//    }else{
//        
//    }
//    
//    
//}

- (void)dismissPKview:(UIButton *)sender
{
    [UIButton beginAnimations:@"ZoomoutButton" context:nil];
    [UIButton setAnimationDuration:1];
    sender.frame = CGRectMake(0, 200, 10, 10);
    sender.center = CGPointMake(160, 240);
    [sender removeFromSuperview];
    [UIButton commitAnimations];
}
- (void)showPKView:(NSInteger)count
{
    UIButton *pkView = [UIButton buttonWithType:UIButtonTypeCustom];
    pkView.frame = CGRectMake(0, 200, 10, 10);
    pkView.center = CGPointMake(160, 240);
    pkView.backgroundColor = [UIColor purpleColor];
    NSString *title = [NSString stringWithFormat:@"现在出现了%d个票数相同的玩家，需要进行陈述进行pk，陈述完毕之后投票选出谁最有可能是鬼。",count];
    [pkView setTitle:title forState:UIControlStateNormal];
    pkView.titleLabel.numberOfLines = 0;
    pkView.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    [pkView addTarget:self action:@selector(dismissPKview:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pkView];
    
    [UIButton beginAnimations:@"ZoominButton" context:nil];
    [UIButton setAnimationDuration:1];
    pkView.frame = CGRectMake(0, 100, 320, 200);
    pkView.center = CGPointMake(160, 240);
    [UIButton commitAnimations];
}

- (IBAction)finishVote:(id)sender {
    NSInteger maxVoteNumber = 0;
    for (PlayerCard *card in _playerManager.playerCardList) {
        maxVoteNumber = MAX(card.voteNumber, maxVoteNumber);
    }

    NSInteger candidateCount = 0;
    PlayerCard *temp = nil;
    for (PlayerCard *card in _playerManager.playerCardList) {
        if (card.status == DEAD || card.status == JUDGE) {
            continue;
        }
        if (card.voteNumber == maxVoteNumber) {
            card.status = CANDIDATE;
            candidateCount ++;
            temp = card;
        }else{
            NSInteger voteNumber = card.voteNumber;
            card.status = VOTED;
            card.voteNumber = voteNumber;
        }
    }
    
    if (candidateCount == 1) {
        //go end
        self.willDeadPlayerCard = temp;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"确定淘汰%d号玩家?", self.willDeadPlayerCard.index] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alertView show];
        [alertView release];
    }
    else if(candidateCount > 1)
    {
        //pk
        [self showPKView:candidateCount];
        
    }else{
        //bug ?
    }
}

- (IBAction)clickShowButton:(id)sender {
    ShowPlayerCardsController *spc = [[ShowPlayerCardsController alloc] init];
    [self.navigationController pushViewController:spc animated:YES];
    [spc release];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    for (PlayerCard *card in self.playerManager.playerCardList) {
        if (card.status != DEAD && card.status != JUDGE) {
            card.status = VOTE;
        }
        [self.view addSubview:card];
    }
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(performPan:)];  
//    [self.view addGestureRecognizer:pan];
//    [pan release];
    [self.playerManager setVoteDelegate:self];
    self.mainMenuBarView.frame = (CGRect){CGPointMake(0, 430), self.mainMenuBarView.frame.size};
}

- (void)viewDidUnload
{
    [self setMainMenuBarView:nil];
    [self setMainMenuButton:nil];
    [self setChangeVoteNumberController:nil];
    [self setTipsController:nil];
    [self setWillDeadPlayerCard:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark - UIGestureRecognizer delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (gestureRecognizer.view == self.view) {
        return YES;
    }
    return NO;
}

#pragma mark - vote delegate

- (void)didPickedCandidate:(PlayerCard *)playerCard
{
    self.willDeadPlayerCard = playerCard;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"确定淘汰%d号玩家?", playerCard.index] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertView show];
    [alertView release];
}

- (void)willPickCandidate:(PlayerCard *)playerCard
{
    NSLog(@"--------willPickCandidate");
    
    if (self.changeVoteNumberController.view) {
        [self.changeVoteNumberController.view removeFromSuperview];
    }
    ChangeVoteNumberController *cvnc = [[ChangeVoteNumberController alloc] initWithPlayerCard:playerCard] ;
    cvnc.view.frame = (CGRect){CGPointMake((320 - cvnc.view.frame.size.width)/2, 259-cvnc.view.frame.size.height/2), cvnc.view.frame.size};
    self.changeVoteNumberController = cvnc;
    [cvnc release];
    [self.view addSubview:self.changeVoteNumberController.view];
}


- (IBAction)clickprevious:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickBackgroundButton:(id)sender
{
    if (self.changeVoteNumberController.view) {
        [self.changeVoteNumberController.view removeFromSuperview];
    }
}

- (IBAction)clickMainMenu:(id)sender
{
    [self.view bringSubviewToFront:self.mainMenuBarView];
    [self.view bringSubviewToFront:self.mainMenuButton];
    if (self.mainMenuBarView.frame.origin.y < 345) {
        [UIView beginAnimations:@"downMainMenu" context:nil];
        self.mainMenuBarView.frame = (CGRect){CGPointMake(0, 430), self.mainMenuBarView.frame.size};
        [UIView commitAnimations];
    }
    else{
        [UIView beginAnimations:@"upMainMenu" context:nil];
        self.mainMenuBarView.frame = (CGRect){CGPointMake(0, 230), self.mainMenuBarView.frame.size};
        [UIView commitAnimations];
    }
}

- (IBAction)clickContinue:(id)sender
{
    
}

- (IBAction)clickSetting:(id)sender
{
    SettingsController *settings = [[SettingsController alloc] init];
    [self.navigationController pushViewController:settings animated:YES];
    [settings release];
}

- (IBAction)clickHelp:(id)sender
{
    HelpController *hc = [[HelpController alloc] init];
    [self.navigationController pushViewController:hc animated:YES];
    [hc release];
}

- (IBAction)clickQuit:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)clickTips:(id)sender
{
    TipsController *tc = [[TipsController alloc] initWithTips:@"点击牌进行投票"];
    self.tipsController = tc;
    [tc release];
    [self.view addSubview:self.tipsController.view];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        self.willDeadPlayerCard.status = DEAD;
        ResultController *rc = [[ResultController alloc] initWithCurrentPlayerCard:self.willDeadPlayerCard];
        [self.navigationController pushViewController:rc animated:YES];
        [rc release];
    }
    else if (buttonIndex == 1){
        for (PlayerCard *card in self.playerManager.playerCardList) {
            if (card.status != DEAD && card.status != JUDGE) {
                NSInteger voteNumber = card.voteNumber;
                card.status = VOTE;
                card.voteNumber = voteNumber;
            }
        }
    }
}

@end
