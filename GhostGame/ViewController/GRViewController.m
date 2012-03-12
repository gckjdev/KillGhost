//
//  CBController.m
//  CountBean
//
//  Created by  on 12-2-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GRViewController.h"

@implementation GRViewController
@synthesize tapGestureRecognizerEnable = _tapGestureRecognizerEnable;
@synthesize panGestureRecognizerEnable = _panGestureRecognizerEnable;
@synthesize currentKeyboardType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)dealloc
{
    [_tapGesture release];
    [_panGesture release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (void)performTapGesture:(UITapGestureRecognizer *)tap
{
    //over ride
    
}
- (void)performPanGesture:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateEnded) {
        if ([pan translationInView:self.view].x < 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
- (void)setPanGestureRecognizerEnable:(BOOL)enable
{
    _panGestureRecognizerEnable = enable;
//    _panGesture.enabled = enable;
}

- (void)setTapGestureRecognizerEnable:(BOOL)enable
{
    _tapGestureRecognizerEnable = enable;
//    _tapGesture.enabled = enable;

}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(performPanGesture:)];
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(performTapGesture:)];
    _panGesture.enabled = NO;
    _tapGesture.enabled = NO;
    [self.view addGestureRecognizer:_panGesture];
    [self.view addGestureRecognizer:_tapGesture];
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (gestureRecognizer.view == self.view) {
        return YES;
    }
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_tapGestureRecognizerEnable) {
        _tapGesture.enabled = YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_tapGestureRecognizerEnable) {
        _tapGesture.enabled = NO;
    }
}

@end
