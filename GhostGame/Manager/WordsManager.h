//
//  WordsManager.h
//  GhostGame
//
//  Created by haodong qiu on 12年2月6日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <Foundation/Foundation.h>
#define LAST_USED_CATEGORY @"LAST_USED_CATEGORY"

@class Words;
@interface WordsManager : NSObject

+ (WordsManager *)defaultManager;

- (NSArray *)getAllWords;
- (NSArray *)getAllCategory;
- (NSArray *)getWordsArrayByCategory:(NSString*)categoryValue;
- (void)addUsedWords:(Words *)words;
@end

extern WordsManager* GlobalGetWordsManager();