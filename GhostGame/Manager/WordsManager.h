//
//  WordsManager.h
//  GhostGame
//
//  Created by haodong qiu on 12年2月6日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordsManager : NSObject

+ (WordsManager *)defaultManager;

- (NSArray *)getAllWords;
- (NSArray *)getAllCategoryId;
- (NSString *)getNameByCategoryId:(NSNumber*)categoryIdValue;
- (NSArray *)getWordsArrayByCategoryId:(NSNumber*)categoryIdValue;

@end

extern WordsManager* GlobalGetWordsManager();