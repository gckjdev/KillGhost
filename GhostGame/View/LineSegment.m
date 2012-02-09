//
//  LineSegment.m
//  mianshi
//
//  Created by  on 12-2-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LineSegment.h"

@implementation LineSegment
@synthesize startPoint = _start;
@synthesize endPoint = _end;


- (id)init{
    self = [super init];
    if(self)
    {
        self.startPoint = CGPointMake(0, 0);
        self.endPoint = CGPointMake(0, 0);
    }
    return self;
}

- (id)initWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    self = [super init];
    if(self)
    {
        self.startPoint = startPoint;
        self.endPoint = endPoint;
    }
    return self;
}


- (void)dealloc
{
    [super dealloc];
}
+ (BOOL) isPointA:(CGPoint)pointA equalToPointB:(CGPoint)pointB{
    return (pointA.x == pointB.x && pointA.y == pointB.y);
}

+ (BOOL)lineSegment:(LineSegment *)lineSeg contains:(CGPoint)point
{
    if ([lineSeg isAPoint]) {
        return [LineSegment isPointA:point equalToPointB:lineSeg.startPoint];
    }
    if ([LineSegment isPointA:lineSeg.startPoint equalToPointB:point]) {
        return YES;
    }
    if ([LineSegment isPointA:lineSeg.endPoint equalToPointB:point]){
        return YES;
    }
    if ((lineSeg.endPoint.x - lineSeg.startPoint.x) * (lineSeg.endPoint.y - point.y) 
        == (lineSeg.endPoint.y - lineSeg.startPoint.y) * (lineSeg.endPoint.x - point.x)) {
        return YES;
    }
    return NO;
}

- (BOOL) isAPoint
{
    return [LineSegment isPointA:_start equalToPointB:_end];
}
- (BOOL) contains:(CGPoint)point
{
    if ([self isAPoint]) {
        return [LineSegment isPointA:point equalToPointB:_start];
    }
    if ([LineSegment isPointA:_start equalToPointB:point]) {
        return YES;
    }
    if ([LineSegment isPointA:_end equalToPointB:point]){
        return YES;
    }
    if ((_end.x - _start.x) * (_end.y - point.y) == (_end.y - _start.y) * (_end.x - point.x)) {
        return YES;
    }
    return NO;
}
- (CGPoint)calculateVector;
{
    return CGPointMake(self.endPoint.x - self.startPoint.x, self.endPoint.y - self.startPoint.y);
}
+ (CGFloat)crossProductLineSegment:(LineSegment *)lineA intersectsWithLineSegment:(LineSegment *)lineB
{
    CGPoint vectorA = [lineA calculateVector];
    CGPoint vectorB = [lineB calculateVector];
    return vectorA.x * vectorB.y - vectorA.y * vectorB.x;
}

- (CGFloat)directionWithPoint:(CGPoint)point
{
    
    LineSegment *line = [[LineSegment alloc] initWithStartPoint:_start endPoint:point];
    CGFloat result =  [LineSegment crossProductLineSegment:line intersectsWithLineSegment:self];
    [line release];
    return result;
}

+ (BOOL) lineSegment:(LineSegment *)lineA intersectsWithLineSegment:(LineSegment *)lineB
{
    CGFloat d1 = [lineA directionWithPoint:lineB.startPoint];
    CGFloat d2 = [lineA directionWithPoint:lineB.endPoint];
    CGFloat d3 = [lineB directionWithPoint:lineA.startPoint];
    CGFloat d4 = [lineB directionWithPoint:lineA.endPoint];
    if (d1 * d2 < 0 && d3 * d4 < 0) 
        return YES;
    return NO;
}

- (BOOL)intersectsWithLineSegment:(LineSegment *)line
{
    return [LineSegment lineSegment:self intersectsWithLineSegment:line];
}

@end
