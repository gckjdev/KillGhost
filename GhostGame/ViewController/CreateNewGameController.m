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

//- (UITextField *)createTextFieldWithKeyBoradType:(UIKeyboardType)type
//{
//    UITextField *textField = [[[UITextField alloc] initWithFrame:CGRectMake(120, 2, 100, 40)] autorelease];
//    textField.delegate = self;
//    textField.keyboardType = type;
//    textField.returnKeyType = UIReturnKeyDone;
//    textField.borderStyle = UITextBorderStyleRoundedRect;
//    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    return textField;
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
     //   [self setPlayerNumberTextField:[self createTextFieldWithKeyBoradType:UIKeyboardTypeNumberPad]];
//        
//        [self setWordLengthTextField:[self createTextFieldWithKeyBoradType:UIKeyboardTypeNumberPad]];
//        [self setCivilianWordTextField:[self createTextFieldWithKeyBoradType:UIKeyboardTypeDefault]];
//        [self setFoolWordTextField:[self createTextFieldWithKeyBoradType:UIKeyboardTypeDefault]];
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
    NSLog(@"%@",self.playerNumberTextField.text);
    if (textField == self.civilianWordTextField) {
        self.wordLengthTextField.text = [NSString stringWithFormat:@"%d",textField.text.length];
    }else if (textField == self.playerNumberTextField) {
        NSInteger count = [textField.text integerValue];
        if (count < 7) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"人数不对哦" message:@"人数不足哦，至少7个人!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [alert release];
            return;
        }else if(count > 13)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"人数不对" message:@"人数太对，玩不了哦!建议分成几群人玩。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
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
    Game *game = [[Game alloc] initWithGhostNumber:gNumber ghostWord:gWord civilianNumber:cNumber civilianWord:cWord foolNumber:fNumber foolWord:fWord]; 
    PickRoleController *pickRoleController = [[PickRoleController alloc] initWithGame:game];
    [game release];
    [self.navigationController pushViewController:pickRoleController animated:YES];
    [pickRoleController release];
    
    Words *words = [[Words alloc] initWithCivilianWord:civilianWordTextField.text foolWord:foolWordTextField.text category:LAST_USED_CATEGORY];
    
    WordsManager *manager = [WordsManager defaultManager];
    [manager addUsedWords:words];
    //    [ConfigureManager addWords:words];
    [words release];
    
    //   PlayGameController
    //    if ((gNumber > 0) & (cNumber > 0) & (fNumber > 0) & ([gWord length] > 0) & ([cWord length] > 0) & ([fWord length] > 0)) {
    //        
    //    }else{
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"信息不完整,或者人数小于0" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    //        [alert show];
    //        [alert release];
    //    }
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
    [super textFieldDidBeginEditing:textField];
    _currentTextField = textField;
    //    [self setTapGestureRecognizerEnable:YES];
   // CGFloat width = stepTable.frame.size.width;
   // CGFloat height = stepTable.frame.size.height;
    if (textField == self.wordLengthTextField || 
        textField == self.foolWordTextField || 
        textField == self.civilianWordTextField) {
        
        if (self.view.frame.origin.y ==0 ) {
            [UIView beginAnimations:@"up" context:nil];
            self.view.frame = CGRectOffset(self.view.frame,0, -160);
            [UIView commitAnimations];
        }

        
//        if (textField == self.civilianWordTextField) {
         //   stepTable.frame = CGRectMake(0, -200, width, height);
//        }else{
           // stepTable.frame = CGRectMake(0, -160, width, height);
//        }
      //  NSIndexPath *path = [NSIndexPath indexPathForRow:3 inSection:2];
     //   [stepTable scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
//    else if(textField == self.civilianNumber){
//        NSIndexPath *path = [NSIndexPath indexPathForRow:2 inSection:1];
//        [stepTable scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
//    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //    [self setTapGestureRecognizerEnable:NO];
    [super textFieldDidEndEditing:textField];
//    CGFloat width = stepTable.frame.size.width;
//    CGFloat height = stepTable.frame.size.height;
//    stepTable.frame = CGRectMake(0, 0, width, height);

        self.view.frame = (CGRect){CGPointMake(0, 0), self.view.frame.size};
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

- (UIButton *)getRandomWordsButton
{
    UIButton *randomWord = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    randomWord.frame = CGRectMake(20, 2, 80, 40);
    [randomWord setTitle:@"随即选词" forState:UIControlStateNormal];
    [randomWord addTarget:self action:@selector(randomWords:) forControlEvents:UIControlEventTouchUpInside];
    return randomWord;
}

- (IBAction)pickWords:(id)sender
{
    PickerCategoryController *pcc = [[PickerCategoryController alloc] init];
    pcc.delegate = self;
    [self.navigationController pushViewController:pcc animated:YES];
    [pcc release];
}

- (UIButton *)getPickWordsButton
{
    UIButton *randomWord = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    randomWord.frame = CGRectMake(180, 2, 80, 40);
    [randomWord setTitle:@"选词" forState:UIControlStateNormal];
    [randomWord addTarget:self action:@selector(pickWords:) forControlEvents:UIControlEventTouchUpInside];
    return randomWord;
}

//#pragma mark - table view delegate
//
//enum
//{
//    INDEX_TOTAL_NUMBER = 0,
//    INDEX_ROLE_NUMBER,
//    INDEX_ROLE_WORD,
//    INDEX_COUNT
//};
//
//- (UILabel *)createLabelWithText:(NSString *)text
//{
//    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 2, 100, 40)] autorelease];
//    label.backgroundColor = [UIColor clearColor];
//    [label setText:text];
//    return label;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    switch (section) {
//        case INDEX_TOTAL_NUMBER:
//            return 1;
//        case INDEX_ROLE_NUMBER:
//            return 3;
//        case INDEX_ROLE_WORD:
//            return 4;
//        default:
//            return 1;
//    }
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSInteger section = indexPath.section;
//    NSInteger row = indexPath.row;
//    static NSString *CellIdentifier = @"StepCell";
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell==nil) {
//        cell=[[[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    switch (section) {
//        case INDEX_TOTAL_NUMBER:
//            [cell.contentView addSubview:self.playerNumber];   
//            return cell;
//        case INDEX_ROLE_NUMBER:
//            if(row == 0)
//            {
//                //ghost number
//                UILabel *label = [self createLabelWithText:@"鬼人数"];
//                [cell.contentView addSubview:label];
//                [cell.contentView addSubview:ghostNumber];
//            }else if(row == 1)
//            {
//                //fool number
//                UILabel *label = [self createLabelWithText:@"傻子人数"];
//                [cell.contentView addSubview:label];
//                [cell.contentView addSubview:foolNumber];
//            }else if(row == 2)
//            {
//                //civilian number
//                UILabel *label = [self createLabelWithText:@"平民人数"];
//                [cell.contentView addSubview:label];
//                [cell.contentView addSubview:civilianNumber];
//            }
//            
//            return cell;
//        case INDEX_ROLE_WORD:
//            if (row == 0) {
//                //random or pick word
//                [cell.contentView addSubview:[self getRandomWordsButton]];     
//                [cell.contentView addSubview:[self getPickWordsButton]];
//                
//            }else if(row == 1)
//            {//ghost tips
//                UILabel *label = [self createLabelWithText:@"鬼提示"];
//                [cell.contentView addSubview:label];
//                [cell.contentView addSubview:wordLength];
//            }else if(row == 2){
//                //fool word
//                UILabel *label = [self createLabelWithText:@"傻子词语"];
//                [cell.contentView addSubview:label];
//                [cell.contentView addSubview:foolWord];
//                
//            }else if(row == 3){
//                //civilian word
//                UILabel *label = [self createLabelWithText:@"平民词语"];
//                [cell.contentView addSubview:label];
//                [cell.contentView addSubview:civilianWord];
//            }
//            return cell;
//        default:
//            return cell;
//    }
//    return cell;
//    
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    switch (section) {
//        case INDEX_TOTAL_NUMBER:
//            return @"第一步: 设置总人数.";
//        case INDEX_ROLE_NUMBER:
//            return @"第二步: 设置每种角色人数.";
//        case INDEX_ROLE_WORD:
//            return @"第三步: 设置每种角色关键词.";
//        default:
//            return nil;
//    }
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return INDEX_COUNT;
//}
//

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

#pragma mark - pick words delegate
- (void)didPickedWords:(Words *)words
{
    [self setFieldsWithWords:words];
}

@end
