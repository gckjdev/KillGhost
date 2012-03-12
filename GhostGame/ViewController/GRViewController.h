//
//  CBController.h
//  CountBean
//
//  Created by  on 12-2-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRViewController : UIViewController<UIGestureRecognizerDelegate, UITextFieldDelegate>
{
    UITapGestureRecognizer *_tapGesture;
    UIPanGestureRecognizer *_panGesture;
    UIKeyboardType currentKeyboardType;
}

@property(nonatomic, assign, getter = isTapGestureRecognizerEnable) BOOL tapGestureRecognizerEnable;
@property(nonatomic, assign, getter = isPanGestureRecognizerEnable) BOOL panGestureRecognizerEnable;
@property(nonatomic, assign) UIKeyboardType currentKeyboardType;

- (void)performTapGesture:(UITapGestureRecognizer *)tap;
- (void)performPanGesture:(UIPanGestureRecognizer *)pan;
@end
