//
//  VoteController.m
//  GhostGame
//
//  Created by  on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VoteController.h"
#import "PlayerCardManager.h"
#import "PlayerCard.h"
#import "LineSegment.h"
#import "LineSegmentView.h"

@implementation VoteController
@synthesize playerManager = _playerManager;
@synthesize lineViewArray = _lineViewArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)constructLineSegments
{
    _lineViewArray = [[NSMutableArray alloc] init];
    for (PlayerCard *card in self.playerManager.playerCardList) {
        LineSegment *line = [[LineSegment alloc] init];
        LineSegmentView *lineView = [[LineSegmentView alloc] initWithWithLineSegment:line];
        [self.lineViewArray addObject:lineView];
        [self.view addSubview:lineView];
        [line release];
        [lineView release];
    }
}

- (id)init
{
    self = [super init];
    if(self){
        self.playerManager = [PlayerCardManager defaultManager];
        [self constructLineSegments];
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
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)isPoint:(CGPoint)point insideRect:(CGRect)rect
{
    if (point.x < rect.origin.x || point.y < rect.origin.y) {
        return NO;
    }
    if (point.x > rect.origin.x + rect.size.width || 
        point.y > rect.origin.y + rect.size.height) {
        return NO;
    }
    return YES;
}

- (PlayerCard *)playCardBeenTouchAtPoint:(CGPoint)point
{
    for(PlayerCard *card in _playerManager.playerCardList)
    {
        if ([self isPoint:point insideRect:card.frame]) {
            return card;
        }
    }
    return nil;
}


//
- (void)performPan:(UIPanGestureRecognizer *)pan
{
    CGPoint location = [pan locationInView:self.view];
    if (pan.state == UIGestureRecognizerStateBegan) {
        //card 
        PlayerCard *card = [self playCardBeenTouchAtPoint:location];
        if (card) {
            
        }

    }else if(pan.state == UIGestureRecognizerStateChanged){
        
    }else if(pan.state == UIGestureRecognizerStateEnded)
    {
        
    }else{
        
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    for (PlayerCard *card in self.playerManager.playerCardList) {
        card.status = DEAD;
        [self.view addSubview:card];
    }
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(performPan:)];  
    [self.view addGestureRecognizer:pan];
    [pan release];
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



#pragma mark - UIGestureRecognizer delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (gestureRecognizer.view == self.view) {
        return YES;
    }
    return NO;
}
@end
