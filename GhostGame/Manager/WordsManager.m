//
//  WordsManager.m
//  GhostGame
//
//  Created by haodong qiu on 12年2月6日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "WordsManager.h"
#import "Words.h"

@implementation WordsManager

- (NSArray *)getAllWords
{
    
    NSArray *civilian = [NSArray arrayWithObjects:@"火龙果", @"桌子", @"门",@"大米",nil];
    
    NSArray *fool = [NSArray arrayWithObjects:@"苹果",     @"椅子",   @"窗",@"小米", nil];
    
    NSMutableArray * wordsArray = [[[NSMutableArray alloc] init] autorelease];
    
    int index = 0;
    for (NSString *str in civilian) {
        
        Words *words = [[Words alloc] initWithCivilianWord:str foolWord:[fool objectAtIndex:index]];
        
        [wordsArray addObject:words];
        
        [words release];
        
        index++;
    }
    
    return wordsArray;
}

@end
