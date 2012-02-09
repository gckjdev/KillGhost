//
//  CreatGameController.m
//  GhostGame
//
//  Created by gamy on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CreateGameController.h"
#import "PickRoleController.h"
#import "Game.h"
#import "Words.h"
#import "WordsManager.h"
#import "UIUtils.h"
#import "PickerCategoryController.h"

@implementation CreateGameController
@synthesize playerNumber;
@synthesize ghostNumber;
@synthesize civilianNumber;
@synthesize foolNumber;
@synthesize wordLength;
@synthesize civilianWord;
@synthesize foolWord;
@synthesize stepTable;

- (UITextField *)createTextFieldWithKeyBoradType:(UIKeyboardType)type
{
    UITextField *textField = [[[UITextField alloc] initWithFrame:CGRectMake(120, 2, 100, 40)] autorelease];
    textField.delegate = self;
    textField.keyboardType = type;
    textField.returnKeyType = UIReturnKeyDone;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    return textField;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setPlayerNumber:[self createTextFieldWithKeyBoradType:UIKeyboardTypeNumberPad]];
        [self setGhostNumber:[self createTextFieldWithKeyBoradType:UIKeyboardTypeNumberPad]];
        [self setCivilianNumber:[self createTextFieldWithKeyBoradType:UIKeyboardTypeNumberPad]];
        [self setFoolNumber:[self createTextFieldWithKeyBoradType:UIKeyboardTypeNumberPad]];
        
        [self setWordLength:[self createTextFieldWithKeyBoradType:UIKeyboardTypeNumberPad]];
        [self setCivilianWord:[self createTextFieldWithKeyBoradType:UIKeyboardTypeDefault]];
        [self setFoolWord:[self createTextFieldWithKeyBoradType:UIKeyboardTypeDefault]];
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
    [stepTable release];
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
    if (_currentTextField) {
        [_currentTextField resignFirstResponder];
        
        if (_currentTextField == self.civilianWord) {
            self.wordLength.text = [NSString stringWithFormat:@"%d",_currentTextField.text.length];
        }else if (_currentTextField == self.playerNumber) {
            NSInteger count = [_currentTextField.text integerValue];
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
            self.ghostNumber.text = [NSString stringWithFormat:@"%d",ghost];
            self.foolNumber.text = [NSString stringWithFormat:@"%d",fool];
            self.civilianNumber.text = [NSString stringWithFormat:@"%d",civilian];
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
    [self setStepTable:nil];
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
    CGFloat width = stepTable.frame.size.width;
    CGFloat height = stepTable.frame.size.height;
    if (textField == self.wordLength || 
        textField == self.foolWord || 
        textField == self.civilianWord) {
        if (textField == self.civilianWord) {
            stepTable.frame = CGRectMake(0, -200, width, height);
        }else{
            stepTable.frame = CGRectMake(0, -160, width, height);
        }
        NSIndexPath *path = [NSIndexPath indexPathForRow:3 inSection:2];
        [stepTable scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    else if(textField == self.civilianNumber){
        NSIndexPath *path = [NSIndexPath indexPathForRow:2 inSection:1];
        [stepTable scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self setTapGestureRecognizerEnable:NO];
    CGFloat width = stepTable.frame.size.width;
    CGFloat height = stepTable.frame.size.height;
    stepTable.frame = CGRectMake(0, 0, width, height);
}

- (void)setFieldsWithWords:(Words *)words
{
    self.civilianWord.text = words.civilianWord;
    self.foolWord.text = words.foolWord;
    self.wordLength.text = [NSString stringWithFormat:@"%d",[words.civilianWord length]];
}
- (void)randomWords:(id)sender
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

- (void)pickWords:(id)sender
{
    PickerCategoryController *pcc = [[PickerCategoryController alloc] init];
    [self.navigationController pushViewController:pcc animated:YES];
    pcc.delegate = self;
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

#pragma mark - table view delegate

enum
{
    INDEX_TOTAL_NUMBER = 0,
    INDEX_ROLE_NUMBER,
    INDEX_ROLE_WORD,
    INDEX_COUNT
};

- (UILabel *)createLabelWithText:(NSString *)text
{
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 2, 100, 40)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    [label setText:text];
    return label;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case INDEX_TOTAL_NUMBER:
            return 1;
        case INDEX_ROLE_NUMBER:
            return 3;
        case INDEX_ROLE_WORD:
            return 4;
        default:
            return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    static NSString *CellIdentifier = @"StepCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
//    return cell;
    switch (section) {
        case INDEX_TOTAL_NUMBER:
            [cell.contentView addSubview:self.playerNumber];   
            return cell;
        case INDEX_ROLE_NUMBER:
            if(row == 0)
            {
                //ghost number
                UILabel *label = [self createLabelWithText:@"鬼人数"];
                [cell.contentView addSubview:label];
                [cell.contentView addSubview:ghostNumber];
            }else if(row == 1)
            {
                //fool number
                UILabel *label = [self createLabelWithText:@"傻子人数"];
                [cell.contentView addSubview:label];
                [cell.contentView addSubview:foolNumber];
            }else if(row == 2)
            {
                //civilian number
                UILabel *label = [self createLabelWithText:@"平民人数"];
                [cell.contentView addSubview:label];
                [cell.contentView addSubview:civilianNumber];
            }
            
            return cell;
        case INDEX_ROLE_WORD:
            if (row == 0) {
                //random or pick word
                [cell.contentView addSubview:[self getRandomWordsButton]];     
                [cell.contentView addSubview:[self getPickWordsButton]];
                
            }else if(row == 1)
            {//ghost tips
                UILabel *label = [self createLabelWithText:@"鬼提示"];
                [cell.contentView addSubview:label];
                [cell.contentView addSubview:wordLength];
            }else if(row == 2){
            //fool word
                UILabel *label = [self createLabelWithText:@"傻子词语"];
                [cell.contentView addSubview:label];
                [cell.contentView addSubview:foolWord];
                
            }else if(row == 3){
                //civilian word
                UILabel *label = [self createLabelWithText:@"平民词语"];
                [cell.contentView addSubview:label];
                [cell.contentView addSubview:civilianWord];
            }
            return cell;
        default:
            return cell;
    }
    return cell;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case INDEX_TOTAL_NUMBER:
            return @"第一步: 设置总人数.";
        case INDEX_ROLE_NUMBER:
            return @"第二步: 设置每种角色人数.";
        case INDEX_ROLE_WORD:
            return @"第三步: 设置每种角色关键词.";
        default:
            return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return INDEX_COUNT;
}

#pragma mark - pick words delegate
- (void)didPickedWords:(Words *)words
{
    [self setFieldsWithWords:words];
}
@end
