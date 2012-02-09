//
//  VoteView.h
//  mianshi
//
//  Created by  on 12-2-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LineSegment;
@interface LineSegmentView : UIView
{
    CGPoint _start, _end, _fromPoint, _toPoint;
//    LineSegment *_lineSegment;
    
}

@property(nonatomic, retain) UIColor *color;
@property(nonatomic, assign) CGFloat lineWidth;
@property(nonatomic, retain) LineSegment *lineSegment;

- (id)initWithWithStartPoint:(CGPoint)start endPoint:(CGPoint)end;
- (id)initWithWithLineSegment:(LineSegment *)lineSegment;
- (void)setLineSegment:(LineSegment *)lineSegment;
- (LineSegment *)lineSegment;
- (CGRect)getFrameWithStartPoint:(CGPoint)start endPoint:(CGPoint)end;
- (void)setStartPoint:(CGPoint)start endPoint:(CGPoint)end;
@end
