//
//  MainMenuController.m
//  GhostGame
//
//  Created by  on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainMenuController.h"
#import "CreateGameController.h"
#import "StateController.h"
#import "HelpController.h"
#import "SettingsController.h"
#import <QuartzCore/QuartzCore.h>
#import "LocaleUtils.h"
#import "CreateNewGameController.h"
#import "ColorManager.h"
#import "GADBannerView.h"
#import "AdUtil.h"

@implementation MainMenuController
@synthesize startGameButton;
@synthesize settingButton;
@synthesize helpButton;
@synthesize startGameLine;
@synthesize settingLine;
@synthesize helpLine;
@synthesize bannerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)addAnimationToButton:(UIButton *)button
{
    CABasicAnimation *fallButtonAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    [fallButtonAnimation setDuration:2];
    [fallButtonAnimation setFromValue:[NSValue valueWithCGPoint:CGPointMake(160, 
                                                                            -20-button.center.y)]];
    [fallButtonAnimation setToValue:[NSValue valueWithCGPoint:button.center]];
    [fallButtonAnimation setFillMode:kCAFillModeForwards];
    [fallButtonAnimation setRemovedOnCompletion:NO];    
    fallButtonAnimation.delegate = self;
    
    CABasicAnimation *stayButtonAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    [stayButtonAnimation setDuration:2];
    [stayButtonAnimation setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.4, 0, 0, 1)]];
    [stayButtonAnimation setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.4, 0, 0, 1)]];
    
    CABasicAnimation *rotateButton = [CABasicAnimation animationWithKeyPath:@"transform"];
    [rotateButton setDuration:0.2];
    [rotateButton setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(-0.1, 0, 0, 1)]];
    [rotateButton setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.1, 0, 0, 1)]];
    [rotateButton setAutoreverses:YES];
    [rotateButton setRepeatCount:1];
    [rotateButton setRemovedOnCompletion:YES]; 
    [rotateButton setBeginTime:CACurrentMediaTime() + 2];
    
    
    [button.layer removeAllAnimations];
    [button.layer addAnimation:rotateButton forKey:@"rotateButton"];
    [button.layer addAnimation:fallButtonAnimation forKey:@"fallButton"];
    [button.layer addAnimation:stayButtonAnimation forKey:@"stayButton"];
}

- (void)addAnimationToLine:(UIImageView *)button
{
    CABasicAnimation *fallButtonAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    [fallButtonAnimation setDuration:2];
    [fallButtonAnimation setFromValue:[NSValue valueWithCGPoint:CGPointMake(160, 
                                                                            -120-button.center.y)]];
    [fallButtonAnimation setToValue:[NSValue valueWithCGPoint:button.center]];
    [fallButtonAnimation setFillMode:kCAFillModeForwards];
    [fallButtonAnimation setRemovedOnCompletion:NO];    
    fallButtonAnimation.delegate = self;
    
    [button.layer removeAllAnimations];
    [button.layer addAnimation:fallButtonAnimation forKey:@"fallButton"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addAnimationToButton:startGameButton];
    [self addAnimationToButton:settingButton];
    [self addAnimationToButton:helpButton];
    
    [self addAnimationToLine:startGameLine];
    [self addAnimationToLine:settingLine];
    [self addAnimationToLine:helpLine];
    
    [self.startGameButton setTitle:NSLS(@"kStart") forState:UIControlStateNormal];
    [self.settingButton setTitle:NSLS(@"kSettings") forState:UIControlStateNormal];
    [self.helpButton setTitle:NSLS(@"kHelp") forState:UIControlStateNormal];
    
    [self.startGameButton setTitleColor:[ColorManager mainMenuColor] forState:UIControlStateNormal];
    [self.settingButton setTitleColor:[ColorManager mainMenuColor] forState:UIControlStateNormal];
    [self.helpButton setTitleColor:[ColorManager mainMenuColor] forState:UIControlStateNormal];
}

- (void)viewDidUnload
{
    [self setStartGameButton:nil];
    [self setSettingButton:nil];
    [self setHelpButton:nil];
    [self setStartGameLine:nil];
    [self setSettingLine:nil];
    [self setHelpLine:nil];
    [self setBannerView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)viewDidAppear:(BOOL)animated
{
    if (bannerView == nil){
        bannerView = [AdUtil allocAdMobView:self];  
    }
    
    [super viewDidAppear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)clickHelp:(id)sender {
    HelpController *hc = [[HelpController alloc] init];
    [self.navigationController pushViewController:hc animated:YES];
    [hc release];
}

- (IBAction)clickSettings:(id)sender {
    SettingsController *settings = [[SettingsController alloc] init];
    [self.navigationController pushViewController:settings animated:YES];
    [settings release];
}

- (IBAction)clickStartGame:(id)sender {
//    CreateGameController *cc = [[CreateGameController alloc] init];
//    [self.navigationController pushViewController:cc animated:YES];
//    [cc release];
    
    CreateNewGameController *cc = [[CreateNewGameController alloc] init];
    [self.navigationController pushViewController:cc animated:YES];
    [cc release];
}
- (void)dealloc {
    [startGameButton release];
    [settingButton release];
    [helpButton release];
    [startGameLine release];
    [settingLine release];
    [helpLine release];
    [bannerView release];
    [super dealloc];
}



@end
