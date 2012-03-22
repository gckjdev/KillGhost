//
//  SettingsController.m
//  GhostGame
//
//  Created by  on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SettingsController.h"
#import "ConfigureManager.h"
#import "LocaleUtils.h"
#import "ColorManager.h"

@implementation SettingsController
@synthesize passwordField;
@synthesize defaultTipsSwitch;
@synthesize soundSwitch;
@synthesize resetPasswordLabel;
@synthesize gameSoundLabel;
@synthesize autoTipsLabel;
@synthesize passwordTipsLabel;
@synthesize viewTitleLabel;


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

- (void)performTapGesture:(UITapGestureRecognizer *)tap
{
    [self.passwordField resignFirstResponder];
}
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    [super textFieldDidBeginEditing:textField];
//    textField.text = [ConfigureManager getPassword];
//}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [super textFieldDidEndEditing:textField];    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewTitleLabel.text = NSLS(@"kSettings_short");
    self.resetPasswordLabel.text = NSLS(@"kResetPassword");
    self.gameSoundLabel.text = NSLS(@"kGameSound");
    self.autoTipsLabel.text = NSLS(@"kAutoTips");
    self.resetPasswordLabel.textColor = [ColorManager helpColor];
    self.gameSoundLabel.textColor = [ColorManager helpColor];
    self.autoTipsLabel.textColor = [ColorManager helpColor];
    self.passwordTipsLabel.textColor = [ColorManager helpColor];
    
    [self setTapGestureRecognizerEnable:YES];

    self.defaultTipsSwitch.on = [ConfigureManager getIsDefaultTips];
    self.soundSwitch.on = [ConfigureManager getHaveSound];
    
    passwordField.text = [ConfigureManager getPassword];
    
    if ([ConfigureManager getPassword]) {
        self.passwordTipsLabel.hidden = YES;
    }
}

- (void)viewDidUnload
{
    [self setPasswordField:nil];
    [self setPasswordTipsLabel:nil];
    [self setDefaultTipsSwitch:nil];
    [self setSoundSwitch:nil];
    [self setViewTitleLabel:nil];
    [self setResetPasswordLabel:nil];
    [self setGameSoundLabel:nil];
    [self setAutoTipsLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [passwordField release];
    [passwordTipsLabel release];
    [defaultTipsSwitch release];
    [soundSwitch release];
    [viewTitleLabel release];
    [resetPasswordLabel release];
    [gameSoundLabel release];
    [autoTipsLabel release];
    [super dealloc];
}

- (IBAction)clickMusicSwitch:(id)sender
{
    UISwitch *currentSwitch = (UISwitch *)sender;
    if (currentSwitch.on)
    {
        [ConfigureManager setHaveSound:YES];
    }
    else {
        [ConfigureManager setHaveSound:NO];
    }
}

- (IBAction)clickDefaultTipsSwitch:(id)sender
{
    UISwitch *currentSwitch = (UISwitch *)sender;
    if (currentSwitch.on) {
        [ConfigureManager setIsDefaultTips:YES];
    }
    else {
        [ConfigureManager setIsDefaultTips:NO];
    }
}

- (IBAction)clickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickSave:(id)sender {
    [ConfigureManager setPassword:passwordField.text];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
