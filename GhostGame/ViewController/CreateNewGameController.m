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
#import "LocaleUtils.h"
#import "ColorManager.h"

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
@synthesize footerView;
@synthesize viewTitleLabel;
@synthesize firstStepLabel;
@synthesize judgeLabel;
@synthesize ghostLabel;
@synthesize foolLabel;
@synthesize civilianLabel;
@synthesize secondStepLabel;
@synthesize ghostWordLabel;
@synthesize foolWordLabel;
@synthesize civilianWordLabel;


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
    [coverView release];
    [footerView release];
    [viewTitleLabel release];
    [firstStepLabel release];
    [judgeLabel release];
    [ghostLabel release];
    [foolLabel release];
    [civilianLabel release];
    [secondStepLabel release];
    [ghostWordLabel release];
    [foolWordLabel release];
    [civilianWordLabel release];
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
    [self updateButtonStatus];
    if (textField == self.civilianWordTextField) {
        self.wordLengthTextField.text = [NSString stringWithFormat:@"%d",textField.text.length];
    }else if (textField == self.playerNumberTextField) {
        NSInteger count = [textField.text integerValue];
        if (count < 7 || count > 13) {
            [self hideNumber];
            self.playerNumberTextField.text = @"";
            NSString *message = nil;
            if (count < 7) {
                message = NSLS(@"kTooLittle");
            }
            else {
                message = NSLS(@"kTooMuch");
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:NSLS(@"kSure") otherButtonTitles:nil];
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
    self.footerView.status = CLOSED;
}

- (void)showFooter
{
    FooterView *fv = [[FooterView alloc] init];
    self.footerView = fv;
    [fv release];
    
    self.footerView.currentViewController = self;
    self.footerView.tips = NSLS(@"kTips1");
    [self.footerView.nextButton addTarget:self action:@selector(clickNewGame:)  forControlEvents:UIControlEventTouchUpInside];
    self.footerView.nextButton.hidden = YES;
    [self.footerView show];
}

- (void)updateButtonStatus
{
    if (self.playerNumberTextField.text.integerValue >= 7 
        && self.playerNumberTextField.text.integerValue <= 13
        && self.civilianWordTextField.text.length > 0
        && self.foolWordTextField.text.length > 0) {
        self.footerView.nextButton.hidden = NO;
    }
    else {
        self.footerView.nextButton.hidden = YES;
    }
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    srand(time(0) - rand() % time(0));
    [self.coverView setHidden:YES];
    [self setTapGestureRecognizerEnable:YES];
    [self hideNumber];
    
    [self showFooter];
    
    viewTitleLabel.text = NSLS(@"kGameInit");
    firstStepLabel.text = NSLS(@"kFirstSept");
    judgeLabel.text = NSLS(@"kJudge");
    ghostLabel.text = NSLS(@"kGhost");
    foolLabel.text = NSLS(@"kFool");
    civilianLabel.text = NSLS(@"kCivilian");
    secondStepLabel.text = NSLS(@"kSecondSept");
    ghostWordLabel.text = NSLS(@"kGhostWord");
    foolWordLabel.text = NSLS(@"kFoolWord");
    civilianWordLabel.text = NSLS(@"kCivilianWord");
    
    firstStepLabel.textColor = [ColorManager createGameColor];
    judgeLabel.textColor = [ColorManager createGameColor];
    ghostLabel.textColor = [ColorManager createGameColor];
    foolLabel.textColor = [ColorManager createGameColor];
    civilianLabel.textColor = [ColorManager createGameColor];
    secondStepLabel.textColor= [ColorManager createGameColor];
    ghostWordLabel.textColor = [ColorManager createGameColor];
    foolWordLabel.textColor = [ColorManager createGameColor];
    civilianWordLabel.textColor = [ColorManager createGameColor];
    
    if ([ConfigureManager getisOnceTips] == YES) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLS(@"kRemindMessage") delegate:self cancelButtonTitle:NSLS(@"kNotRemind") otherButtonTitles:NSLS(@"kContinueRemind"), nil];
        [alert show];
        [alert release];
    }

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
    [self setCoverView:nil];
    [self setFooterView:nil];
    [self setViewTitleLabel:nil];
    [self setFirstStepLabel:nil];
    [self setJudgeLabel:nil];
    [self setGhostLabel:nil];
    [self setFoolLabel:nil];
    [self setCivilianLabel:nil];
    [self setSecondStepLabel:nil];
    [self setGhostWordLabel:nil];
    [self setFoolWordLabel:nil];
    [self setCivilianWordLabel:nil];
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLS(@"kNotSetNumber") delegate:nil cancelButtonTitle:NSLS(@"kSure") otherButtonTitles:nil];
        [alert show];
        [alert release];
        return ;
    }
    
    if (civilianWordTextField.text.length == 0 || self.foolWordTextField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLS(@"kNotSetWord") delegate:nil cancelButtonTitle:NSLS(@"kSure") otherButtonTitles:nil];
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
        
        self.coverView.hidden = YES;
        
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
    [self updateButtonStatus];
}


- (IBAction)pickWords:(id)sender
{
    PickerCategoryController *pcc = [[PickerCategoryController alloc] init];
    pcc.delegate = self;
    [self.navigationController pushViewController:pcc animated:YES];
    [pcc release];
}


#pragma mark - pick words delegate
- (void)didPickedWords:(Words *)words
{
    [self setFieldsWithWords:words];
    [self updateButtonStatus];
}

#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 ) {
        [ConfigureManager setIsOnceTips:NO];
    }
}

@end
