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

@implementation PickerCategoryController
@synthesize categoryIdArray;
@synthesize categoryTable;
@synthesize delegate;

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
    self.categoryIdArray = [[WordsManager defaultManager] getAllCategoryId];
    
}

- (void)viewDidUnload
{
    [self setCategoryIdArray:nil];
    [self setCategoryTable:nil];
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
    [categoryIdArray release];
    [categoryTable release];
    [super dealloc];
}

#pragma mark - tableView data source delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categoryIdArray count];
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

    
    cell.textLabel.text = [[WordsManager defaultManager] getNameByCategoryId:[self.categoryIdArray objectAtIndex:indexPath.row]];
    
    
    
    return cell;
}



#pragma mark - tableView delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PickerWordsController *pwc = [[PickerWordsController alloc] initWithCategoryId:[self.categoryIdArray objectAtIndex:indexPath.row]];
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


@end
