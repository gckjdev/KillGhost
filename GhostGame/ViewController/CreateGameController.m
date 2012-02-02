//
//  CreatGameController.m
//  GhostGame
//
//  Created by gamy on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CreateGameController.h"
#import "Game.h"
#import "PickRoleController.h"
@implementation CreateGameController
@synthesize playerNumber;
@synthesize ghostNumber;
@synthesize civilianNumber;
@synthesize foolNumber;
@synthesize wordLength;
@synthesize civilianWord;
@synthesize foolWord;

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
    [ghostNumber release];
    [civilianNumber release];
    [foolNumber release];
    [wordLength release];
    [civilianWord release];
    [foolWord release];
    [playerNumber release];
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
//    [ghostNumber resignFirstResponder];
//    [civilianNumber resignFirstResponder];
//    [foolNumber resignFirstResponder];
//    [wordLength resignFirstResponder];
//    [civilianWord resignFirstResponder];
//    [foolWord resignFirstResponder];
    if (_currentTextField) {
        [_currentTextField resignFirstResponder];
        if (_currentTextField == self.playerNumber) {
            NSInteger count = [_currentTextField.text integerValue];
            switch (count) {
                case 8:
                {
                    self.ghostNumber.text = @"2";
                    self.foolNumber.text = @"1";
                    self.civilianNumber.text = @"4";
                }
                    break;
                case 9:
                {
                    self.ghostNumber.text = @"2";
                    self.foolNumber.text = @"1";
                    self.civilianNumber.text = @"5";
                }
                    break;
                case 10:
                {
                    self.ghostNumber.text = @"3";
                    self.foolNumber.text = @"1";
                    self.civilianNumber.text = @"5";
                }
                    break;
                case 11:
                {
                    self.ghostNumber.text = @"3";
                    self.foolNumber.text = @"1";
                    self.civilianNumber.text = @"6";
                }
                    break;
                case 12:
                {
                    self.ghostNumber.text = @"3";
                    self.foolNumber.text = @"2";
                    self.civilianNumber.text = @"6";
                }
                    break;
                case 13:
                {
                    self.ghostNumber.text = @"4";
                    self.foolNumber.text = @"1";
                    self.civilianNumber.text = @"7";
                }
                    break;
                default:
                    break;
            }
        }
    }
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setGhostNumber:nil];
    [self setCivilianNumber:nil];
    [self setFoolNumber:nil];
    [self setWordLength:nil];
    [self setCivilianWord:nil];
    [self setFoolWord:nil];
    [self setPlayerNumber:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)clickNewGame:(id)sender {
    NSInteger gNumber = [self.ghostNumber.text integerValue];
    NSInteger cNumber = [self.civilianNumber.text integerValue];
    NSInteger fNumber = [self.foolNumber.text integerValue];
    NSString *gWord = [self.wordLength text];
    NSString *cWord = self.civilianWord.text;
    NSString *fWord = self.foolWord.text;
    Game *game = [[Game alloc] initWithGhostNumber:gNumber ghostWord:gWord civilianNumber:cNumber civilianWord:cWord foolNumber:fNumber foolWord:fWord]; 
    PickRoleController *playGame = [[PickRoleController alloc] initWithGame:game];
    [game release];
    [self.navigationController pushViewController:playGame animated:YES];
 //   PlayGameController
//    if ((gNumber > 0) & (cNumber > 0) & (fNumber > 0) & ([gWord length] > 0) & ([cWord length] > 0) & ([fWord length] > 0)) {
//        
//    }else{
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"信息不完整,或者人数小于0" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alert show];
//        [alert release];
//    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _currentTextField = textField;
    [self setTapGestureRecognizerEnable:YES];

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self setTapGestureRecognizerEnable:NO];

}
@end
