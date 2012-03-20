//
//  PickerWordsController.m
//  GhostGame
//
//  Created by  on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PickerWordsController.h"
#import "Words.h"
#import "WordsManager.h"
#import "PickerWordsCell.h"
#import "ConfigureManager.h"
#import "LocaleUtils.h"
#import "ColorManager.h"

@implementation PickerWordsController
@synthesize category;
@synthesize wordsArray;
@synthesize wordsTable;
@synthesize selectCellIndex;
@synthesize delegate;
@synthesize viewTitleLabel;
@synthesize civilianWordLabel;
@synthesize foolWordLabel;
@synthesize backLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)clickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithCategory:(NSString *)categoryValue
{
    self = [super init];
    if (self) {
        self.category = categoryValue;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewTitleLabel.text = NSLS(@"kSelectWords");
    self.civilianWordLabel.text = NSLS(@"kCivilianWord");
    self.foolWordLabel.text = NSLS(@"kFoolWord");
    self.backLabel.text = NSLS(@"kBack");
    
    self.wordsArray = [[WordsManager defaultManager] getWordsArrayByCategory:self.category];
    self.selectCellIndex = -1;
    
}

- (void)viewDidUnload
{
    [self setCategory:nil];
    [self setWordsArray:nil];
    [self setWordsTable:nil];
    [self setViewTitleLabel:nil];
    [self setCivilianWordLabel:nil];
    [self setFoolWordLabel:nil];
    [self setBackLabel:nil];
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
    [category release];
    [wordsArray release];
    [wordsTable release];
    [viewTitleLabel release];
    [civilianWordLabel release];
    [foolWordLabel release];
    [backLabel release];
    [super dealloc];
}

#pragma mark - tableView data source delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.wordsArray count];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"pickerWords";
    
    PickerWordsCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PickerWordsCell" owner:self options:nil];
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[PickerWordsCell class]])
                cell = (PickerWordsCell *)oneObject;
        }
    }
    
    Words *word = [self.wordsArray objectAtIndex:indexPath.row];
    
    cell.civilianWordLabel.text = word.civilianWord;
    cell.foolWordLabel.text = word.foolWord;
    cell.civilianWordLabel.textColor = [ColorManager wordColor];
    cell.foolWordLabel.textColor = [ColorManager wordColor];
    
    if (self.selectCellIndex == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}



#pragma mark - tableView delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectCellIndex = indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    if (delegate && [delegate respondsToSelector:@selector(didPickedWords:)]) {
        
        Words *word = nil;
        if ([self.category isEqualToString:LAST_USED_CATEGORY]) {
            word = [self.wordsArray objectAtIndex:indexPath.row];
        }else{
            word = [self.wordsArray objectAtIndex:indexPath.row];
        }
        [delegate didPickedWords:word];
    }
    //[self.navigationController popViewControllerAnimated:YES];
    NSUInteger currentIndex = [[self.navigationController viewControllers] indexOfObject:self];
    NSUInteger popToIndex = currentIndex - 2;
    
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:popToIndex] animated:YES];
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath { 
    return NO; 
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
}

@end
