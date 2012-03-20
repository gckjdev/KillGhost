//
//  HelpController.m
//  GhostGame
//
//  Created by haodong qiu on 12年2月7日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "HelpController.h"
#import "LocaleUtils.h"
#import "ColorManager.h"

@implementation HelpController
@synthesize descriptionTextView;
@synthesize flowChartScrollView;
@synthesize TextButton;
@synthesize ImageButton;
@synthesize backLabel;
@synthesize viewTitleLabel;
@synthesize TriangleImageView;

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
- (void)addTextToFlowChart
{
    NSArray *stepArray = [NSArray arrayWithObjects:NSLS(@"kFlowChartTitle1"), NSLS(@"kFlowChartTitle2"), NSLS(@"kFlowChartTitle3"), NSLS(@"kFlowChartTitle4"), NSLS(@"kFlowChartTitle5"), NSLS(@"kFlowChartTitle6"), NSLS(@"kFlowChartTitle7"), nil];
    NSInteger num = 0;
    for (NSString *str in stepArray) {
        CGFloat y ;
        switch (num) {
            case 0:
                y = 62;
                break;
            case 1:
                y = 207;
                break;
            case 2:
                y = 388;
                break;
            case 3:
                y = 545;
                break;
            case 4:
                y = 680;
                break;
            case 5:
                y = 846;
                break;
            case 6:
                y = 1006;
                break;
            default:
                break;
        }
        UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 290, 20)];
        stepLabel.text = str;
        stepLabel.font = [UIFont boldSystemFontOfSize:16];
        stepLabel.backgroundColor = [UIColor clearColor];
        stepLabel.textColor = [ColorManager helpColor];
        stepLabel.textAlignment = UITextAlignmentCenter;
        [self.flowChartScrollView addSubview:stepLabel];
        [stepLabel release];
        num ++;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewTitleLabel.text = NSLS(@"kHelp_short");
    self.backLabel.text = NSLS(@"kBack");
    self.descriptionTextView.text = NSLS(@"kHelpText");
    self.descriptionTextView.textColor = [ColorManager helpColor];
    
    [self.TextButton setImage:[UIImage imageNamed:@"text_button_selected.png"] forState:UIControlStateNormal];
    self.flowChartScrollView.hidden = YES;
    self.flowChartScrollView.contentSize = CGSizeMake(292, 1037);
    [self addTextToFlowChart];
}

- (void)viewDidUnload
{
    [self setDescriptionTextView:nil];
    [self setFlowChartScrollView:nil];
    [self setTextButton:nil];
    [self setImageButton:nil];
    [self setTriangleImageView:nil];
    [self setBackLabel:nil];
    [self setViewTitleLabel:nil];
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
    
    [self.TextButton setImage:[UIImage imageNamed:@"text_button_selected.png"] forState:UIControlStateNormal];
    [self.ImageButton setImage:[UIImage imageNamed:@"picture_button.png"] forState:UIControlStateNormal];
    self.TriangleImageView.frame = (CGRect){CGPointMake(85, 133), self.TriangleImageView.frame.size};
    
}

- (IBAction)clickFlowChart:(id)sender
{
    self.descriptionTextView.hidden = YES;
    self.flowChartScrollView.hidden = NO;
    
    [self.TextButton setImage:[UIImage imageNamed:@"text_button.png"] forState:UIControlStateNormal];
    [self.ImageButton setImage:[UIImage imageNamed:@"picture_button_selected.png"] forState:UIControlStateNormal];
    self.TriangleImageView.frame = (CGRect){CGPointMake(214, 133), self.TriangleImageView.frame.size};
}

- (IBAction)clickBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    [descriptionTextView release];
    [flowChartScrollView release];
    [TextButton release];
    [ImageButton release];
    [TriangleImageView release];
    [backLabel release];
    [viewTitleLabel release];
    [super dealloc];
}
@end
