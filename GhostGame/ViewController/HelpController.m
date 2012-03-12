//
//  HelpController.m
//  GhostGame
//
//  Created by haodong qiu on 12年2月7日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "HelpController.h"

@implementation HelpController
@synthesize descriptionTextView;
@synthesize flowChartScrollView;
@synthesize footerController;

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
    self.flowChartScrollView.hidden = YES;
    self.flowChartScrollView.contentSize = CGSizeMake(292, 812);
    
    
    NSArray *stepArray = [NSArray arrayWithObjects:@"确定人数", @"确认身份和词语", @"第一轮描述词语", @"投票淘汰", @"下一轮游戏", nil];
    
    NSInteger num = 0;
    for (NSString *str in stepArray) {
        UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150 * num + 61, 290, 20)];
        stepLabel.text = str;
        stepLabel.backgroundColor = [UIColor clearColor];
        stepLabel.textAlignment = UITextAlignmentCenter;
        [self.flowChartScrollView addSubview:stepLabel];
        [stepLabel release];
        
        num ++;
    }
    
    
    FooterController *fc = [[[FooterController alloc] init] autorelease];
    fc.view.frame = CGRectMake(0,442,320,38);
    [fc setSuperView:self.view buttonTarget:self nextButtonTitle:@"下一步" nextButtonActon:@selector(clickFlowChart:) previousButtonTitle:@"下一步" nextButtonActon:@selector(clickFlowChart:)];
    self.footerController = fc;
    [fc release];
    [self.footerController show];
    
//    [fc setNextButtonAction:@selector(clickFlowChart:) target:self];
//    self.footerController = fc;
//    [fc release];
//    [self.view addSubview:self.footerController.view];
}

- (void)viewDidUnload
{
    [self setDescriptionTextView:nil];
    [self setFlowChartScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)clickText:(id)sender{
    self.descriptionTextView.hidden = NO;
    self.flowChartScrollView.hidden = YES;
}

- (IBAction)clickFlowChart:(id)sender
{
    self.descriptionTextView.hidden = YES;
    self.flowChartScrollView.hidden = NO;
}

- (IBAction)clickBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    [descriptionTextView release];
    [flowChartScrollView release];
    [super dealloc];
}
@end
