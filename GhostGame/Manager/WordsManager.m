//
//  WordsManager.m
//  GhostGame
//
//  Created by haodong qiu on 12年2月6日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "WordsManager.h"
#import "Words.h"

WordsManager *wordsManger;
WordsManager *GlobalGetWordsManager()
{
    if (wordsManger == nil) {
        wordsManger = [[WordsManager alloc] init];
    }
    return wordsManger;
}

@implementation WordsManager

- (id)init
{
    if((self = [super init]) != nil)
    {
        
    }
    return self;
}
+ (WordsManager *)defaultManager
{
    return GlobalGetWordsManager();
}


#pragma mark - last used words list

#define WORDS_LIST @"WORDS_LIST"

- (void)setUsedWordsList:(NSArray *)wordsList
{
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:wordsList];
    [userDefault setObject:data forKey:WORDS_LIST];
    [userDefault synchronize];
}

- (NSArray *)getWordsListWithCount:(NSInteger)count
{
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSData* data = [userDefault objectForKey:WORDS_LIST];
    NSArray *temp = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (count <= 0) {
        return temp;
    }else{
        NSMutableArray *retArray = [[NSMutableArray alloc] init];
        int j = 0;
        for (int i = [temp count] - 1; i >= 0 && j <= count; --i, ++j) {
            [retArray addObject:[temp objectAtIndex:i]];
        }
        return [retArray autorelease];
    }
}

- (NSInteger)indexInArray:(NSArray *)array ForWords:(Words *)words
{
    if (array && words) {
        int i = 0;
        for (Words *obj in array) {
            if ([obj isEqualToWords:words]) {
                return i;
            }
            ++ i;
        }
    }
    return  - 1;
}

- (void)addUsedWords:(Words *)words
{
    NSArray *temp = [self getWordsListWithCount:-1];
    NSMutableArray *storeArray = [NSMutableArray arrayWithArray:temp];
    
    NSInteger index = [self indexInArray:storeArray ForWords:words];
    
    if (index != -1) {
        [storeArray removeObjectAtIndex:index];
    }
    [storeArray insertObject:words atIndex:0];
    [self setUsedWordsList:storeArray];
}


- (NSArray *)getAllWords
{
    
    NSMutableArray * wordsArray = [[[NSMutableArray alloc] init] autorelease];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Words" 
													 ofType:@"plist"];	
    
    NSDictionary *allData = [[NSDictionary alloc] initWithContentsOfFile:path];   
    NSArray *categoryArray = [allData allKeys];
    
    for (NSString *category in categoryArray) {
        NSDictionary *dic = [allData objectForKey:category];
        NSArray *civilianWordArray = [dic allKeys];
        
        for (NSString *civilianWord in civilianWordArray) {
            
            Words *words = [[Words alloc] initWithCivilianWord:civilianWord foolWord:[dic objectForKey:civilianWord] category:category];
            
            [wordsArray addObject:words];
        }
    }
    
    [allData release];
    
    return wordsArray;
}

- (NSArray *)getAllCategory
{
    NSMutableArray *categoryArray = [[[NSMutableArray alloc] init] autorelease];
    [categoryArray addObject:LAST_USED_CATEGORY];
    NSArray *allWords = [self getAllWords];
    
    for (Words *words in allWords) {
        if ([categoryArray indexOfObject:words.category] == NSNotFound) {
            [categoryArray addObject:words.category];
        }
    }
    
    return categoryArray;
}

- (NSArray *)getWordsArrayByCategory:(NSString*)categoryValue
{
    if ([categoryValue isEqualToString:LAST_USED_CATEGORY]) {
       return [self getWordsListWithCount:-1];
    }else{
    
        NSMutableArray *wordsArray = [[[NSMutableArray alloc] init] autorelease];
        
        NSArray *allWords = [self getAllWords];
        
        for (Words *words in allWords) {
            if ([words.category isEqual:categoryValue]) {
                [wordsArray addObject:words];
            }
        }
        return wordsArray;
    }
}




@end
