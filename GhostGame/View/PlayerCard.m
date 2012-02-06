//
//  PlayerCard.m
//  GhostGame
//
//  Created by  on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PlayerCard.h"
#import "Player.h"

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
    _fontSize = FONT_SIZE * scale;
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

- (void)performTap:(UITapGestureRecognizer *)tap
{
    [self.superview bringSubviewToFront:self];
    [UIView beginAnimations:@"span" context:NULL];
    [UIView setAnimationDuration:1];
    if (self.status == UNSHOW) {
        [self setScale:6 center:CGPointMake(160, 220)];
        self.status = SHOWING;
    }else{
        [self setScale:1 center:_position];
        self.status = UNSHOW;
    }
    [UIView commitAnimations];
}
- (void)defaultSetting
{
    cardSize = CGSizeMake(CARD_WIDTH, CARD_HEIGHT);
    imageSize = CGSizeMake(IMAGE_WIDHT, IMAGE_HEIGHT);
    _fontSize = FONT_SIZE;
    self.status = UNSHOW;
    self.frame = [self defaultFrame];
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
        [self defaultSetting];
        self.center = position;
        UIImage *img = [PlayerCard imageForPlayerType:player.type];
		imageRef = CGImageRetain(img.CGImage);
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)dealloc
{
    [_player release];
    CGImageRelease(imageRef);
    [super dealloc];
}


- (void)drawRectCardBack
{
    CGRect imageRect;
    CGContextRef context = UIGraphicsGetCurrentContext();
	imageRect.origin = CGPointMake(0, 0);
	imageRect.size = CGSizeMake(10, 10);
    CGContextClipToRect(context, CGRectMake(0.0, 0, self.bounds.size.width, self.bounds.size.height));
	CGContextDrawTiledImage(context, imageRect, [UIImage imageNamed:@"mask.png"].CGImage);
}

- (void)drawRectCardFront
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //text
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
	CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0));
    [_player.word drawAtPoint:CGPointMake(0, imageSize.width + 3) withFont:[UIFont systemFontOfSize:_fontSize]];
    
    
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
    if (self.status == SHOWING) {
        [self drawRectCardFront];
    }else{
        [self drawRectCardBack];
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
