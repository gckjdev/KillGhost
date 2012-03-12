//
//  CreateNewGameController.m
//  GhostGame
//
//  Created by haodong qiu on 12年3月2日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "CreateNewGameController.h"
#import "PickRoleController.h"
#import "Game.h"
#import "Words.h"
#import "WordsManager.h"
#import "UIUtils.h"
#import "PickerCategoryController.h"
#import "ConfigureManager.h"
#import "SettingsController.h"
#import "HelpController.h"


@implementation CreateNewGameController
@synthesize coverView;
@synthesize playerNumberTextField;
@synthesize judgeNumberLabel;
@synthesize ghostNumberLabel;
@synthesize foolNumberLabel;
@synthesize civilianNumberLabel;
@synthesize judgeNumberImageView;
@synthesize ghostNumberImageView;
@synthesize foolNumberImageView;
@synthesize civilianNumberImageView;
@synthesize wordLengthTextField;
@synthesize foolWordTextField;
@synthesize civilianWordTextField;
@synthesize mainMenuBarView;
@synthesize tipsController;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
 
    }
    return self;
}

- (void)dealloc {
    [playerNumberTextField release];
    [judgeNumberLabel release];
    [ghostNumberLabel release];
    [foolNumberLabel release];
    [civilianNumberLabel release];
    [wordLengthTextField release];
    [foolWordTextField release];
    [civilianWordTextField release];
    [judgeNumberImageView release];
    [ghostNumberImageView release];
    [foolNumberImageView release];
    [civilianNumberImageView release];
    [mainMenuBarView release];
    [tipsController release];
    [coverView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)hideNumber
{
    self.judgeNumberImageView.hidden = YES;
    self.ghostNumberImageView.hidden = YES;
    self.foolNumberImageView.hidden = YES;
    self.civilianNumberImageView.hidden = YES;
    
    self.judgeNumberLabel.hidden = YES;
    self.ghostNumberLabel.hidden = YES;
    self.foolNumberLabel.hidden = YES;
    self.civilianNumberLabel.hidden = YES;
}

- (void)showNumber
{
    self.judgeNumberImageView.hidden = NO;
    self.ghostNumberImageView.hidden = NO;
    self.foolNumberImageView.hidden = NO;
    self.civilianNumberImageView.hidden = NO;
    
    self.judgeNumberLabel.hidden = NO;
    self.ghostNumberLabel.hidden = NO;
    self.foolNumberLabel.hidden = NO;
    self.civilianNumberLabel.hidden = NO;
}

- (void)finishEdited:(UITextField *)textField
{
    if (textField == self.civilianWordTextField) {
        self.wordLengthTextField.text = [NSString stringWithFormat:@"%d",textField.text.length];
    }else if (textField == self.playerNumberTextField) {
        NSInteger count = [textField.text integerValue];
        if (count < 7) {
            [self hideNumber];
            self.playerNumberTextField.text = @"";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"人数不足哦，至少7个人！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [alert release];
            return;
        }else if(count > 13)
        {
            [self hideNumber];
            self.playerNumberTextField.text = @"";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"人数太多，玩不了哦！建议分成几群人玩。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [alert release];
            return;
        }
        
        NSInteger ghost, civilian, fool;
        if (count >= 12) {
            fool = 2;
        }else{
            fool = 1;
        }
        
        if (count >= 10) {
            ghost = 3;
        }else{
            ghost = 2;
        }
        
        civilian = count - ghost - fool - 1;
        
        [self showNumber];
        
        self.judgeNumberLabel.text = @"1"; 
        self.ghostNumberLabel.text = [NSString stringWithFormat:@"%d",ghost];
        self.foolNumberLabel.text = [NSString stringWithFormat:@"%d",fool];
        self.civilianNumberLabel.text = [NSString stringWithFormat:@"%d",civilian];
    }
}

- (void)performTapGesture:(UITapGestureRecognizer *)tap
{
    if (_currentTextField) {
        [_currentTextField resignFirstResponder];
        [self finishEdited:_currentTextField];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.coverView setHidden:YES];
    [self setTapGestureRecognizerEnable:YES];
    [self hideNumber];
    self.mainMenuBarView.frame = (CGRect){CGPointMake(0, 430), self.mainMenuBarView.frame.size};
}



- (void)viewDidUnload
{
    [self setPlayerNumberTextField:nil];
    [self setJudgeNumberLabel:nil];
    [self setGhostNumberLabel:nil];
    [self setFoolNumberLabel:nil];
    [self setCivilianNumberLabel:nil];
    [self setWordLengthTextField:nil];
    [self setFoolWordTextField:nil];
    [self setCivilianWordTextField:nil];
    [self setJudgeNumberImageView:nil];
    [self setGhostNumberImageView:nil];
    [self setFoolNumberImageView:nil];
    [self setCivilianNumberImageView:nil];
    [self setMainMenuBarView:nil];
    [self setTipsController:nil];
    [self setCoverView:nil];
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
    
    NSInteger gNumber = [self.ghostNumberLabel.text integerValue];
    NSInteger cNumber = [self.civilianNumberLabel.text integerValue];
    NSInteger fNumber = [self.foolNumberLabel.text integerValue];
    NSString *gWord = [self.wordLengthTextField text];
    NSString *cWord = self.civilianWordTextField.text;
    NSString *fWord = self.foolWordTextField.text;
    
    if (self.playerNumberTextField.text.integerValue < 7 || self.playerNumberTextField.text.integerValue > 13) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"没设定人数哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return ;
    }
    
    if (civilianWordTextField.text.length == 0 || self.foolWordTextField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"没设定键字哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return ;
    }
    
    
    Game *game = [[Game alloc] initWithGhostNumber:gNumber ghostWord:gWord civilianNumber:cNumber civilianWord:cWord foolNumber:fNumber foolWord:fWord]; 
    PickRoleController *pickRoleController = [[PickRoleController alloc] initWithGame:game];
    [game release];
    [self.navigationController pushViewController:pickRoleController animated:YES];
    [pickRoleController release];
    
    Words *words = [[Words alloc] initWithCivilianWord:civilianWordTextField.text foolWord:foolWordTextField.text category:LAST_USED_CATEGORY];
    
    WordsManager *manager = [WordsManager defaultManager];
    [manager addUsedWords:words];
    [words release];

}

- (IBAction)clickBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self finishEdited:textField];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.coverView setHidden:NO];
    [super textFieldDidBeginEditing:textField];
    _currentTextField = textField;
    self.currentKeyboardType = textField.keyboardType;
    if (textField == self.wordLengthTextField || 
        textField == self.foolWordTextField || 
        textField == self.civilianWordTextField) {
        
        if (self.view.frame.origin.y ==0 ) {
            [UIView beginAnimations:@"upView" context:nil];
            self.view.frame = CGRectOffset(self.view.frame,0, -180);
            [UIView commitAnimations];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.coverView setHidden:YES];

    [super textFieldDidEndEditing:textField];
    [UIView beginAnimations:@"downView" context:nil];
    self.view.frame = (CGRect){CGPointMake(0, 0), self.view.frame.size};
    [UIView commitAnimations];
}

- (void)setFieldsWithWords:(Words *)words
{
    
    self.civilianWordTextField.text = words.civilianWord;
    self.foolWordTextField.text = words.foolWord;
    self.wordLengthTextField.text = [NSString stringWithFormat:@"%d",[words.civilianWord length]];
}

- (IBAction)randomWords:(id)sender
{
    WordsManager *manager = [WordsManager defaultManager];
    NSArray *wordsArray = [manager getAllWords];
    NSInteger index = rand() % [wordsArray count];
    Words *words = [wordsArray objectAtIndex:index];
    [self setFieldsWithWords:words];
}



- (IBAction)pickWords:(id)sender
{
    PickerCategoryController *pcc = [[PickerCategoryController alloc] init];
    pcc.delegate = self;
    [self.navigationController pushViewController:pcc animated:YES];
    [pcc release];
}



- (IBAction)clickMainMenu:(id)sender
{
    if (self.mainMenuBarView.frame.origin.y < 345) {
        [UIView beginAnimations:@"downMainMenu" context:nil];
        self.mainMenuBarView.frame = (CGRect){CGPointMake(0, 430), self.mainMenuBarView.frame.size};
        [UIView commitAnimations];
    }
    else{
        [UIView beginAnimations:@"upMainMenu" context:nil];
        self.mainMenuBarView.frame = (CGRect){CGPointMake(0, 230), self.mainMenuBarView.frame.size};
        [UIView commitAnimations];
    }
}

- (IBAction)clickContinue:(id)sender
{
    
}

- (IBAction)clickSetting:(id)sender
{
    SettingsController *settings = [[SettingsController alloc] init];
    [self.navigationController pushViewController:settings animated:YES];
    [settings release];
}

- (IBAction)clickHelp:(id)sender
{
    HelpController *hc = [[HelpController alloc] init];
    [self.navigationController pushViewController:hc animated:YES];
    [hc release];
}

- (IBAction)clickQuit:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)clickTips:(id)sender
{
    TipsController *tc = [[TipsController alloc] initWithTips:@"确定人数以及选择词语"];
    self.tipsController = tc;
    [tc release];
    [self.view addSubview:self.tipsController.view];
}

#pragma mark - pick words delegate
- (void)didPickedWords:(Words *)words
{
    [self setFieldsWithWords:words];
}


@end
