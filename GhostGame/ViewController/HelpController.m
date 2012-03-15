//
//  HelpController.m
//  GhostGame
//
//  Created by haodong qiu on 12年2月7日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "HelpController.h"
#import "FooterView.h"
#import "DialogView.h"

@implementation HelpController
@synthesize descriptionTextView;
@synthesize flowChartScrollView;

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
    NSArray *stepArray = [NSArray arrayWithObjects:@"设定人数和词语", @"玩家查看身份和词语", @"第一轮陈述", @"投票淘汰", @"继续下一轮陈述", nil];
    NSInteger num = 0;
    for (NSString *str in stepArray) {
        CGFloat y ;
        switch (num) {
            case 0:
                y = 62;
                break;
            case 1:
                y = 210;
                break;
            case 2:
                y = 390;
                break;
            case 3:
                y = 534;
                break;
            case 4:
                y = 695;
                break;
            default:
                break;
        }
        UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 290, 20)];
        stepLabel.text = str;
        stepLabel.backgroundColor = [UIColor clearColor];
        stepLabel.textAlignment = UITextAlignmentCenter;
        [self.flowChartScrollView addSubview:stepLabel];
        [stepLabel release];
        num ++;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.flowChartScrollView.hidden = YES;
    self.flowChartScrollView.contentSize = CGSizeMake(292, 812);
    [self addTextToFlowChart];
    
    self.descriptionTextView.text =
@"捉鬼游戏是目前最流行的桌游，游戏共有4种角色：法官，平民，鬼，傻子。\n\
\n\
首先选一个玩家做法官，法官拿着iPhone控制游戏的步骤。\n\
\n\
1.设定人数和词语\n\
人数的范围是7至13个（包括法官），词语可以从词库选择，也可以自定义词语。\n\
\n\
2.玩家查看身份和词语\n\
法官确定自己的座号，把iPhone按顺时针顺序传给其他玩家，玩家查看各自的身份和词语，看完之后，把iPhone交回给法官。\n\
\n\
3.鬼相认\n\
法官宣布所有玩家闭眼，所有的鬼睁开眼相互确认一下身份，鬼之间用眼神或手势交流，并用手势告诉法官哪位玩家第一个发言，法官宣布鬼闭眼，法官宣布所有玩家睁开眼。\n\
\n\
4.陈述\n\
由第一个开始按座号顺序发言，发言内容是描述各自看到的词，平民的发言尽量让其他平民知道自己是平民，同时也不要让鬼猜出词语。鬼的发言尽量让平民以为自己是平民。傻子的发言是混淆视听。进行一轮次的发言之后进入投票。\n\
\n\
5.投票淘汰\n\
从第一个开始，同意他是鬼就举手投票，接着下一个，完成一轮次的投票后，法官统计投票结果。(注意：每轮每个人只可以投给一个人)\n\
\n\
6.出局决策\n\
票数最高的玩家出局，如果票数最高的玩家不止一个，则这些玩家进行陈述PK，再次投票选出票数最高者作为出局者。法官查看出局玩家的身份。\n\
(1)如果是不是鬼，则宣布:\"他不是鬼\"，继续下一步；\n\
(2)如果是鬼，则宣布:\"他是鬼,请鬼猜词\"。如果猜对，则宣布:\"鬼获胜\",游戏结束；如果猜错，继续下一步。\n\
\n\
7.继续陈述，胜负判断\n\
出局者的下一位玩家作为第一个发言者，重复步骤4-7。重复进行此步骤直到出现下面的情况：\n\
(1)所有的鬼出局，则平民获胜出，游戏结束。\n\
(2)平民或傻子出局的数量与初始鬼的数量一样，则鬼胜出，游戏结束。";
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
