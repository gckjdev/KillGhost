//
//  SettingsController.m
//  GhostGame
//
//  Created by  on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SettingsController.h"
#import "ConfigureManager.h"


@implementation SettingsController
@synthesize passwordField;

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
    [self setTapGestureRecognizerEnable:YES];
    passwordField.text = [ConfigureManager getPassword];
}

- (void)viewDidUnload
{
    [self setPasswordField:nil];
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
    [super dealloc];
}
- (IBAction)clickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickSave:(id)sender {
    [ConfigureManager setPassword:passwordField.text];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
