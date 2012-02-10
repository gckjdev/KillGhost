//
//  VoteView.m
//  mianshi
//
//  Created by  on 12-2-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LineSegmentView.h"
#import "LineSegment.h"
@implementation LineSegmentView
@synthesize color = _color;
@synthesize lineWidth = _lineWidth;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (CGRect)getFrameWithStartPoint:(CGPoint)start endPoint:(CGPoint)end
{
    CGFloat x = MIN(start.x, end.x);
    CGFloat y = MIN(start.y, end.y);
    CGFloat width = ABS(start.x - end.x);
    CGFloat height = ABS(end.y - start.y);
    return CGRectMake(x, y, width, height);
}

- (id)initWithWithStartPoint:(CGPoint)start endPoint:(CGPoint)end
{
    CGRect frame = [self getFrameWithStartPoint:start endPoint:end];
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setStartPoint:start endPoint:end];
        self.backgroundColor = [UIColor clearColor];
        self.color = [UIColor blackColor];
        self.lineWidth = 2.0;
    }
    return self;
}

- (id)initWithWithLineSegment:(LineSegment *)lineSegment
{
    if (lineSegment) {
        return [self initWithWithStartPoint:lineSegment.startPoint endPoint:lineSegment.endPoint];
    }
    return nil;
    
}
- (void)setLineSegment:(LineSegment *)lineSegment
{
    if (lineSegment) {
        [self setStartPoint:lineSegment.startPoint endPoint:lineSegment.endPoint];
    }
}

- (LineSegment *)lineSegment
{
   return [[[LineSegment alloc] initWithStartPoint:_start endPoint:_end]autorelease];
}
- (void)setColor:(UIColor *)color
{
    if (color != self.color) {
        [_color release];
        _color = [color retain];
        [self setNeedsDisplay];
    }
    
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}
- (void)dealloc
{
    [_color release];
    [super dealloc];
}

//Horizontal line start.y = end.y
- (CGRect)getHorizontalFrameWithStartPoint:(CGPoint)start endPoint:(CGPoint)end
{
    CGFloat x = MIN(start.x, end.x);
    CGFloat y = start.y - _lineWidth;
    CGFloat width = ABS(start.x - end.x);
    CGFloat height = 2 * _lineWidth;
    return CGRectMake(x, y, width, height);
}

//vertical line start.x = end.x
- (CGRect)getVerticalFrameWithStartPoint:(CGPoint)start endPoint:(CGPoint)end
{
    CGFloat x = start.x - _lineWidth;
    CGFloat y = MIN(start.y, end.y);
    CGFloat width = 2 * _lineWidth;
    CGFloat height = ABS(end.y - start.y);
    return CGRectMake(x, y, width, height);
}

- (BOOL) isNumber:(CGFloat)number1 nearNumber:(CGFloat)number2
{
    if (ABS(number1 - number2) <= MAX(_lineWidth, 2.0)) {
        return YES;
    }
    return NO;
}


- (void)setStartPoint:(CGPoint)start endPoint:(CGPoint)end
{
    _start = start;
    _end = end;
    BOOL xNear = [self isNumber:start.x nearNumber:end.x];
    BOOL yNear = [self isNumber:start.y nearNumber:end.y];
    
    if (xNear && yNear) {
        self.frame = [self getFrameWithStartPoint:start endPoint:end];
        _fromPoint = CGPointMake(0, 0);
        _toPoint = CGPointMake(0, 0);
    }else if (xNear && !yNear) {
        self.frame = [self getVerticalFrameWithStartPoint:start endPoint:end];
        _fromPoint = CGPointMake(_lineWidth, _start.y - self.frame.origin.y);
        _toPoint = CGPointMake(_lineWidth, _end.y - self.frame.origin.y);
    }else if (yNear && !xNear) {
        self.frame = [self getHorizontalFrameWithStartPoint:start endPoint:end];
        _fromPoint = CGPointMake(_start.x - self.frame.origin.x, _lineWidth);
        _toPoint = CGPointMake(_end.x - self.frame.origin.x, _lineWidth);
    }else{
        self.frame = [self getFrameWithStartPoint:_start endPoint:_end];
        _fromPoint = CGPointMake(_start.x - self.frame.origin.x, _start.y - self.frame.origin.y);
        _toPoint = CGPointMake(_end.x - self.frame.origin.x, _end.y - self.frame.origin.y);
    }
    
//    if (start.x == end.x && start.y == end.y) {
//        self.frame = [self getFrameWithStartPoint:start endPoint:end];
//        _fromPoint = CGPointMake(0, 0);
//        _toPoint = CGPointMake(0, 0);
//    }else if (start.x == end.x && start.y != end.y) {
//        self.frame = [self getVerticalFrameWithStartPoint:start endPoint:end];
//        _fromPoint = CGPointMake(_lineWidth, _start.y - self.frame.origin.y);
//        _toPoint = CGPointMake(_lineWidth, _end.y - self.frame.origin.y);
//    }else if (start.y == end.y && start.x != end.x) {
//        self.frame = [self getHorizontalFrameWithStartPoint:start endPoint:end];
//        _fromPoint = CGPointMake(_start.x - self.frame.origin.x, _lineWidth);
//        _toPoint = CGPointMake(_end.x - self.frame.origin.x, _lineWidth);
//    }else{
//        self.frame = [self getFrameWithStartPoint:_start endPoint:_end];
//        _fromPoint = CGPointMake(_start.x - self.frame.origin.x, _start.y - self.frame.origin.y);
//        _toPoint = CGPointMake(_end.x - self.frame.origin.x, _end.y - self.frame.origin.y);
//    }
    [self setNeedsDisplay];
}


- (CGPoint)startPoint
{
    return _start;
}
- (CGPoint)endPoint
{
    return _end;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, _color.CGColor);    
    CGContextSetLineWidth(context, _lineWidth);
    CGContextMoveToPoint(context, _fromPoint.x, _fromPoint.y);
    CGContextAddLineToPoint(context, _toPoint.x, _toPoint.y);
    CGContextStrokePath(context);    
//    CGContextStrokeRect(context, self.bounds);
}


@end
