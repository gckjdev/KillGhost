//
//  WordsManager.h
//  GhostGame
//
//  Created by haodong qiu on 12年2月6日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordsManager : NSObject

- (NSArray *)getAllWords;
+ (WordsManager *)defaultManager;
@end

extern WordsManager* GlobalGetWordsManager();