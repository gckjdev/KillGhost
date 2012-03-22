//
//  PlayerCard.m
//  GhostGame
//
//  Created by  on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PlayerCard.h"
#import "Player.h"
#import "UIUtils.h"
#import "ConfigureManager.h"
#import "LocaleUtils.h"
#import "ColorManager.h"

#define CARD_HEIGHT 57
#define CARD_WIDTH  45 //(CARD_HEIGHT * 0.68)
#define IMAGE_WIDHT CARD_WIDTH
#define IMAGE_HEIGHT CARD_HEIGHT
#define FONT_SIZE 12

@implementation PlayerCard
@synthesize player = _player;
@synthesize scale = _scale;
@synthesize fontSize = _fontSize;
@synthesize status = _status;
@synthesize position = _position;
@synthesize delegate = _delegate;
@synthesize passWord = _passWord;
@synthesize voteNumber = _voteNumber;
@synthesize voteForPlayer = _voteForPlayer;
@synthesize index = _index;

- (CGRect)defaultFrame
{
    return CGRectMake(0, 0, CARD_WIDTH, CARD_HEIGHT);
}

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:[self defaultFrame]];
    if (self) {
    }
    return self;
}


- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    cardSize = CGSizeMake(CARD_WIDTH * scale, CARD_HEIGHT * scale);
    imageSize = CGSizeMake(IMAGE_WIDHT * scale, IMAGE_HEIGHT * scale);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, cardSize.width, cardSize.height);
    _fontSize = FONT_SIZE * scale;
    [self setNeedsDisplay];
    
}
- (void)setScale:(CGFloat)scale center:(CGPoint)center
{
    _scale = scale;
    cardSize = CGSizeMake(CARD_WIDTH * scale, CARD_HEIGHT * scale);
    imageSize = CGSizeMake(IMAGE_WIDHT * scale, IMAGE_HEIGHT * scale);
    CGFloat x = center.x - cardSize.width / 2.0;
    CGFloat y = center.y - cardSize.height / 2.0;
    self.frame = CGRectMake(x, y, cardSize.width, cardSize.height);
    _fontSize = FONT_SIZE * scale / 3;
    [self setNeedsDisplay];
    
}

+ (UIImage *)imageForPlayerType:(NSInteger)type
{
    NSString *imagePath = nil;
    
    switch (type) {
        case GhostType:
            imagePath = [[NSBundle mainBundle] pathForResource:@"ghost_card@2x.png" ofType:nil];
            break;
        case FoolType:
            imagePath = [[NSBundle mainBundle] pathForResource:@"fool_card@2x.png" ofType:nil];
            break;
        case CivilianType:
            imagePath = [[NSBundle mainBundle] pathForResource:@"civilian_card@2x.png" ofType:nil];
            break;
        default:
            return nil;
    }
    UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
    return img;
}

- (void)startFlashTimer
{
    //    _flashShowed = YES;
    _flashTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeFrameColor:) userInfo:nil repeats:YES];
    [_flashTimer fire];
}

- (void)stopFlashTimer
{
    if (_flashTimer && [_flashTimer isValid]) {
        [_flashTimer invalidate];
        _flashTimer = nil;
    }
}

- (void)setVoteNumber:(NSInteger)voteNumber
{
    _voteNumber = voteNumber;
    [self setNeedsDisplay];
}

- (void)setStatus:(NSInteger)status
{
    _status = status;
    self.voteForPlayer = nil;
    if (status != CANDIDATE) {
        self.voteNumber = 0;        
    }
    switch (status) {
        case WILLSHOW:
        case UNCERTAIN:
        case CANDIDATE:
        {
            _flashShowed = YES;
            [self setScale:1 center:_position];
            if (![_flashTimer isValid]) {
                [self startFlashTimer];
            }
        }
            break;
        case UNSHOW:
        case SHOWED:
        case VOTE:
        case VOTED:
        case DEAD:
        case EXAMINE:
        case JUDGE:            
            [self stopFlashTimer];    
            [self setScale:1 center:_position];
            break;
        default:
            [self stopFlashTimer];
            [self setScale:320.0 / CARD_WIDTH + 0.2  center:CGPointMake(160, 240)];
            break;
    }
    [self setNeedsDisplay];
}
- (void)show
{
    [self.superview bringSubviewToFront:self];
    [UIView beginAnimations:@"ZoomIn" context:NULL];
    [UIView setAnimationDuration:1];
    self.status = SHOWING;
    [UIView commitAnimations];
}
- (void)cover
{
    [self.superview bringSubviewToFront:self];
    [UIView beginAnimations:@"ZoomOut" context:NULL];
    [UIView setAnimationDuration:1];
    self.status = SHOWED;
    [UIView commitAnimations];
}

- (void)changeFrameColor:(NSTimer *)theTimer
{
    _flashShowed = !_flashShowed;
    [self setNeedsDisplay];
}


- (void)performTap:(UITapGestureRecognizer *)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(respondsToClickPlayerCard:)]) {
        if (![_delegate respondsToClickPlayerCard:self]) {
            return;
        }
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(willClickPlayerCard:)]) {
        [_delegate willClickPlayerCard:self];
    }
    
    if(self.status == SHOWED){
        //need password
        [UIUtils showTextView:NSLS(@"kEntePassword") okButtonTitle:NSLS(@"kSure") cancelButtonTitle:NSLS(@"kCancel") delegate:self secureTextEntry:YES];
    }else if(self.status == SHOWING){
        [self cover];        
    }else if(self.status == WILLSHOW){
        [self show];
    }else if(self.status == CANDIDATE)
    {
        //self.status = DEAD;
    }else if(self.status == VOTE)
    {
        
    }else if(self.status == UNCERTAIN)
    {
        self.status = JUDGE;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(didClickedPlayerCard:)]) {
        [_delegate didClickedPlayerCard:self];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //ok button
        NSString *pw = ((UITextField *)[alertView viewWithTag:kAlertTextViewTag]).text;
        
        if ([pw isEqualToString:[ConfigureManager getPassword]] || ([ConfigureManager getPassword] == nil && [pw isEqualToString:@"abc"])) {
            [self show];
        }else{
            //wrong password
        [UIUtils showTextView:NSLS(@"kEntePassword2") okButtonTitle:NSLS(@"kSure") cancelButtonTitle:NSLS(@"kCancel") delegate:self secureTextEntry:YES];
        }
    }
}

- (void)defaultSetting
{
    cardSize = CGSizeMake(CARD_WIDTH, CARD_HEIGHT);
    imageSize = CGSizeMake(IMAGE_WIDHT, IMAGE_HEIGHT);
    _fontSize = FONT_SIZE;
    self.frame = [self defaultFrame];
    self.backgroundColor = [UIColor clearColor];
    _flashShowed = YES;
    self.status = WILLSHOW;
    self.passWord = [ConfigureManager getPassword];
    self.voteNumber = 0;
    self.voteForPlayer = nil;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(performTap:)];
    [self addGestureRecognizer:tap];
    [tap release];
}

- (id)init{
    self = [super init];
    if (self) {
        [self defaultSetting];
    }
    return self;
}
- (id)initWithPlayer:(Player *)player position:(CGPoint)position showIngindex:(NSInteger)index
{
    self = [super init];
    if (self) {
        self.player = player;
        self.position = position;
        self.center = position;
        self.index = index;
        [self defaultSetting];
    }
    return self;    
}


- (id)initWithPlayer:(Player *)player position:(CGPoint)position showIngindex:(NSInteger)index status:(NSInteger)status
{
    self = [super init];
    if (self) {
        self.player = player;
        self.position = position;
        self.center = position;
        self.index = index;
        [self defaultSetting];
        self.status = status;
    }
    return self;    
}

- (void)dealloc
{
    [_player release];
    [_passWord release];
    [_voteForPlayer release];
//    CGImageRelease(imageRef);
    [super dealloc];
}

- (void)drawImage:(CGContextRef)context fileName:(NSString *)fileName
{
    CGContextTranslateCTM(context, 00, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGRect imageRect;
    imageRect.origin = CGPointMake(0, 0);
    imageRect.size = CGSizeMake(CARD_WIDTH, CARD_HEIGHT);
    UIImage *backImage = [UIImage imageNamed:fileName];
    CGImageRef backImageRef = CGImageRetain(backImage.CGImage);
    CGContextDrawImage(context, imageRect, backImageRef);
}


- (void)drawFlashRect:(CGContextRef)context
{
    if (!_flashShowed) {
        [self drawImage:context fileName: @"frame_light.png"];
    }
}


- (void)drawWillShowCover:(CGContextRef)context
{
    [self drawImage:context fileName:[NSString stringWithFormat:@"card_number_%d.png",self.index]];
    [self drawFlashRect:context];
}



- (void)drawUnShowCover:(CGContextRef)context
{
    [self drawImage:context fileName:[NSString stringWithFormat:@"card_number_%d.png",self.index]];
}

- (void)drawShowedCover:(CGContextRef)context
{
    [self drawImage:context fileName:[NSString stringWithFormat:@"card_number_%d.png",self.index]];
    [self drawImage:context fileName:@"card_shadow.png"];
}

- (void)drawVoteCover:(CGContextRef)context
{    
    [self drawImage:context fileName:[NSString stringWithFormat:@"card_number_%d.png",self.index]];
    
    CGContextTranslateCTM(context, 00, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGRect imageRect;
    imageRect.origin = CGPointMake(27, 0);
    imageRect.size = CGSizeMake(18, 18);
    UIImage *backImage = [UIImage imageNamed:@"number_bg5.png"];
    CGImageRef backImageRef = CGImageRetain(backImage.CGImage);
    CGContextDrawImage(context, imageRect, backImageRef);
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
	CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0));
    
    NSString *tips = [NSString stringWithFormat:@"%d",_voteNumber];    
    [tips drawInRect:CGRectMake(27, 0, 18, 18) withFont:[UIFont systemFontOfSize:14] lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentCenter];
    
    CGContextSaveGState(context);

}

- (void)drawCandidateCover:(CGContextRef)context
{
    [self drawVoteCover:context];
    [self drawFlashRect:context];
}

- (void)drawDeadCover:(CGContextRef)context
{
    //CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    //CGContextFillRect(context, self.bounds);
    [self drawImage:context fileName:[NSString stringWithFormat:@"card_number_%d.png",self.index]];
    [self drawImage:context fileName:@"card_shadow.png"];
    [self drawImage:context fileName:@"ban.png"];
}
- (void)drawShowingRect:(CGContextRef)context
{
    //CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    //CGContextFillRect(context, self.bounds);
    //CGContextSaveGState(context);
    
    //翻转context
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
	CGContextScaleCTM(context, 1.0, -1.0); 
    
    //image
    UIImage *img = [PlayerCard imageForPlayerType:self.player.type];
    imageRef = img.CGImage;//CGImageRetain(img.CGImage);
    CGRect imageRect;
	imageRect.origin = CGPointMake(0, cardSize.height - imageSize.height);
	imageRect.size = CGSizeMake(imageSize.width, imageSize.height);
	CGContextDrawImage(context, imageRect, imageRef);
    
    //画完图，翻转回来
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetFillColorWithColor(context, [ColorManager wordColor].CGColor);
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
	CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0));
    
    [_player.name drawInRect:CGRectMake(0, imageSize.height * 0.7, imageSize.width, 35) withFont:[UIFont systemFontOfSize:_fontSize] lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentCenter];
    
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:244/255.0 green:52/255.0 blue:111/255.0 alpha:1.0].CGColor);
    [_player.word drawInRect:CGRectMake(0, imageSize.height * 0.8, imageSize.width, 35) withFont:[UIFont systemFontOfSize:_fontSize] lineBreakMode:UILineBreakModeMiddleTruncation alignment:UITextAlignmentCenter];
    
    CGContextSetFillColorWithColor(context, [ColorManager wordColor].CGColor);
    NSString *tips = NSLS(@"kRememberIdentityAndWord");
    if (self.player.type == GhostType) {
        tips = NSLS(@"kRememberIdentityAndTips");
    }
    [tips drawInRect:CGRectMake(0, imageSize.height * 0.9, imageSize.width, 20) withFont:[UIFont systemFontOfSize:_fontSize/1.5] lineBreakMode:UILineBreakModeMiddleTruncation alignment:UITextAlignmentCenter];
}

- (void)drawIndexNumber:(CGContextRef)context
{
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
	CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0));
    
    NSString *indexString = [NSString stringWithFormat:@"%d",self.index];    
    if (self.index < 10) {
        [indexString drawAtPoint:CGPointMake(13, 18) withFont:[UIFont systemFontOfSize:25]];        
    }else{
        [indexString drawAtPoint:CGPointMake(5, 18) withFont:[UIFont systemFontOfSize:25]];
    }

    CGContextSaveGState(context);
}

- (void)drawExamine:(CGContextRef)context
{
    [self drawImage:context fileName:@"card_back.png"];
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
	CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0));
    NSString *indexString = [NSString stringWithFormat:@"%d",self.index];    
    [indexString drawInRect:CGRectMake(3, 8, 40, CARD_WIDTH) withFont:[UIFont systemFontOfSize:15] lineBreakMode:UILineBreakModeMiddleTruncation alignment:UITextAlignmentCenter];
    
    if (_player.type == GhostType) {
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    }else if(_player.type == JudgeType)
    {
        CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    }
    else {
        CGContextSetFillColorWithColor(context, [ColorManager wordColor].CGColor);
    }
    [_player.name drawInRect:CGRectMake(3, 28, 40, CARD_WIDTH) withFont:[UIFont systemFontOfSize:15] lineBreakMode:UILineBreakModeMiddleTruncation alignment:UITextAlignmentCenter];
    
    CGContextSaveGState(context);
}


- (void)drawUncertain:(CGContextRef)context
{
    [self drawImage:context fileName:[NSString stringWithFormat:@"card_number_%d.png",self.index]];
    [self drawFlashRect:context];

}

- (void)drawJudge:(CGContextRef)context
{
    [self drawImage:context fileName:[NSString stringWithFormat:@"card_judge.png",self.index]];
    [self drawFlashRect:context];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    switch (self.status) {
        case WILLSHOW:
            [self drawWillShowCover:context];
            break;
        case UNSHOW:
            [self drawUnShowCover:context];
            break;
        case SHOWING:
            [self drawShowingRect:context];
            break;
        case SHOWED:
            [self drawShowedCover:context];
            break;
        case VOTE:
        case VOTED:
            [self drawVoteCover:context];
            break;
        case CANDIDATE:
            [self drawCandidateCover:context];
            break;
        case DEAD:
            [self drawDeadCover:context];
            break;
        case EXAMINE:
            [self drawExamine:context];
            break;
        case UNCERTAIN:
            [self drawUncertain:context];
            break;
        case JUDGE:
            [self drawJudge:context];
            break;
            
        default:
            break;
    }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
    if (touch.view == self) {
        return YES;
    }
    return NO;
}


@end
