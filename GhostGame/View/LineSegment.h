//
//  LineSegment.h
//  mianshi
//
//  Created by  on 12-2-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LineSegment : NSObject {
@private
    CGPoint _start;
    CGPoint _end;
}

@property(nonatomic, assign)CGPoint startPoint;
@property(nonatomic, assign)CGPoint endPoint;

- (id)initWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
- (BOOL) isAPoint;
- (BOOL) contains:(CGPoint)point;
- (BOOL)intersectsWithLineSegment:(LineSegment *)line;

+ (BOOL)lineSegment:(LineSegment *)lineSeg contains:(CGPoint)point;
+ (BOOL) lineSegment:(LineSegment *)lineA intersectsWithLineSegment:(LineSegment *)lineB;
@end