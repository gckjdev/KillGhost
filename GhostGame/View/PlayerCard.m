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

#define CARD_HEIGHT 60
#define CARD_WIDTH  40 //(CARD_HEIGHT * 0.68)
#define IMAGE_WIDHT CARD_WIDTH
#define IMAGE_HEIGHT CARD_WIDTH
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
            imagePath = [[NSBundle mainBundle] pathForResource:@"ghost.png" ofType:nil];
            break;
        case FoolType:
            imagePath = [[NSBundle mainBundle] pathForResource:@"fool.png" ofType:nil];
            break;
        case CivilianType:
            imagePath = [[NSBundle mainBundle] pathForResource:@"civilian.png" ofType:nil];
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
    switch (status) {
        case WILLSHOW:
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
        case DEAD:
            [self stopFlashTimer];    
            [self setScale:1 center:_position];
            break;
        default:
            [self stopFlashTimer];
            [self setScale:7 center:CGPointMake(160, 210)];
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
        [UIUtils showTextView:@"请输入密码" okButtonTitle:@"确定" cancelButtonTitle:@"取消" delegate:self secureTextEntry:YES];
    }else if(self.status == SHOWING){
        [self cover];        
    }else if(self.status == WILLSHOW){
        [self show];
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
        if (pw && [pw isEqualToString:self.passWord]) {
            [self show];
        }else{
            //wrong password
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
    self.passWord = @"123";
    self.voteNumber = 0;
    self.voteForPlayer = nil;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(performTap:)];
    [self addGestureRecognizer:tap];
    [tap release];
}

- (id)initWithPlayer:(Player *)player position:(CGPoint)position
{
    self = [super init];
    if (self) {
        self.player = player;
        self.position = position;
        self.center = position;
        UIImage *img = [PlayerCard imageForPlayerType:player.type];
        imageRef = CGImageRetain(img.CGImage);
        [self defaultSetting];

    }
    return self;
}

- (void)dealloc
{
    [_player release];
    CGImageRelease(imageRef);
    [super dealloc];
}


- (void)drawFlashRect:(CGContextRef)context
{
    if (!_flashShowed) {
        CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    }else{
        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    }
    CGFloat lineWidth = 3.0;
    CGRect frame = CGRectMake(lineWidth / 2, lineWidth / 2, self.frame.size.width - lineWidth, self.frame.size.height - lineWidth); CGContextStrokeRectWithWidth(context, frame, lineWidth);    
    CGContextSaveGState(context);

}

- (void)drawWillShowCover:(CGContextRef)context
{
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
//    if (!_flashShowed) {
//        CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
//    }else{
//        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
//    }
//    CGFloat lineWidth = 3.0;
//    CGRect frame = CGRectMake(lineWidth / 2, lineWidth / 2, self.frame.size.width - lineWidth, self.frame.size.height - lineWidth);
    CGContextFillRect(context, self.bounds);
    CGContextSaveGState(context);
    [self drawFlashRect:context];
//    CGContextStrokeRectWithWidth(context, frame, lineWidth);    
//    CGContextSaveGState(context);

}



- (void)drawUnShowCover:(CGContextRef)context
{
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextFillRect(context, self.bounds);
}

- (void)drawShowedCover:(CGContextRef)context
{
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextFillRect(context, self.bounds);
}

- (void)drawVoteCover:(CGContextRef)context
{
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillRect(context, self.bounds);
    
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillRect(context, self.bounds);
    CGContextSaveGState(context);
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
	CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0));
    
    NSString *tips = [NSString stringWithFormat:@"%d",_voteNumber];    
    [tips drawAtPoint:CGPointMake(3, 3) withFont:[UIFont systemFontOfSize:25]];
    CGContextSaveGState(context);

}

- (void)drawCandidateCover:(CGContextRef)context
{
    [self drawVoteCover:context];
    [self drawFlashRect:context];
}

- (void)drawDeadCover:(CGContextRef)context
{
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillRect(context, self.bounds);
}
- (void)drawShowingRect:(CGContextRef)context
{
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillRect(context, self.bounds);
    CGContextSaveGState(context);
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
	CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0));
    [_player.name drawAtPoint:CGPointMake(10 * _scale, imageSize.width + 3) withFont:[UIFont systemFontOfSize:_fontSize]];
    [_player.word drawAtPoint:CGPointMake(10 * _scale, imageSize.width + 8 * _scale ) withFont:[UIFont systemFontOfSize:_fontSize]];
    
    NSString *tips = @"(请记住你的身份和词语)";
    [tips drawAtPoint:CGPointMake(5 * _scale, imageSize.width + 16 * _scale ) withFont:[UIFont systemFontOfSize:_fontSize/1.5]];
    //image
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
    CGRect imageRect;
	imageRect.origin = CGPointMake(0, cardSize.height - imageSize.height);
	imageRect.size = CGSizeMake(imageSize.width, imageSize.height);
	CGContextDrawImage(context, imageRect, imageRef);
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
            [self drawVoteCover:context];
            break;
        case CANDIDATE:
            [self drawCandidateCover:context];
            break;
        case DEAD:
            [self drawDeadCover:context];
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
