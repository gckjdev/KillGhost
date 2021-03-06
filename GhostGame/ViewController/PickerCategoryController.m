//
//  PickerCategoryController.m
//  GhostGame
//
//  Created by haodong qiu on 12年2月9日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "PickerCategoryController.h"
#import "WordsManager.h"
#import "PickerWordsController.h"
#import "LocaleUtils.h"
#import "ColorManager.h"

@implementation PickerCategoryController
@synthesize categoryArray;
//@synthesize categoryTable;
@synthesize delegate;
@synthesize viewTitleLabel;
@synthesize backLabel;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewTitleLabel.text = NSLS(@"kSelectCategory");
    self.backLabel.text = NSLS(@"kBack");
    
    self.categoryArray = [[WordsManager defaultManager] getAllCategory];
    
}

- (void)viewDidUnload
{
    [self setCategoryArray:nil];
    [self setViewTitleLabel:nil];
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
    [categoryArray release];
    [viewTitleLabel release];
    [backLabel release];
    [super dealloc];
}

#pragma mark - tableView data source delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categoryArray count];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"pickerCategory";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    if (cell == nil) {
        cell=[[[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier] autorelease];
    }
    
//    UITableViewCellAccessoryNone,                   // don't show any accessory view
//    UITableViewCellAccessoryDisclosureIndicator,    // regular chevron. doesn't track
//    UITableViewCellAccessoryDetailDisclosureButton, // blue button w/ chevron. tracks
//    UITableViewCellAccessoryCheckmark               // checkmark. doesn't track
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self.categoryArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [ColorManager wordColor];
    
    if ([cell.textLabel.text isEqualToString:LAST_USED_CATEGORY]) {
        cell.textLabel.text = NSLS(@"kRecentlyUsed");
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
    NSString *str = nil;
    str = [self.categoryArray objectAtIndex:indexPath.row ];
    PickerWordsController *pwc = [[PickerWordsController alloc] initWithCategory:str];
    pwc.delegate = self.delegate;
    [self.navigationController pushViewController:pwc animated:YES];
    [pwc release];
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath { 
    return NO; 
}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 30;
//}


- (IBAction)clickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
