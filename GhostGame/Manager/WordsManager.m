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

- (NSArray *)getAllWords
{
    NSArray *category = [NSArray arrayWithObjects:[NSNumber numberWithInt:WORDS_CATEGORY_FOOD],[NSNumber numberWithInt:WORDS_CATEGORY_OTHER],[NSNumber numberWithInt:WORDS_CATEGORY_OTHER],[NSNumber numberWithInt:WORDS_CATEGORY_ELECTRONICS], nil];
    
    NSArray *civilian = [NSArray arrayWithObjects:@"火龙果", @"桌子", @"门",@"手机",nil];
    
    NSArray *fool = [NSArray arrayWithObjects:@"苹果",     @"椅子",   @"窗",@"耳机", nil];
    
    NSMutableArray * wordsArray = [[[NSMutableArray alloc] init] autorelease];
    
    int index = 0;
    for (NSString *str in civilian) {
        
        Words *words = [[Words alloc] initWithCivilianWord:str foolWord:[fool objectAtIndex:index] categoryId:[category objectAtIndex:index]];
        
        [wordsArray addObject:words];
        
        [words release];
        
        index++;
    }
    
    return wordsArray;
}

- (NSArray *)getAllCategoryId
{
    NSMutableArray *categoryArray = [[[NSMutableArray alloc] init] autorelease];
    
    NSArray *allWords = [self getAllWords];
    
    for (Words *words in allWords) {
        if ([categoryArray indexOfObject:words.categoryId] == NSNotFound) {
            [categoryArray addObject:words.categoryId];
        }
    }
    
    return categoryArray;
}

- (NSString *)getNameByCategoryId:(NSNumber*)categoryIdValue
{
    switch ([categoryIdValue intValue]) {
        case WORDS_CATEGORY_FOOD:
            return @"食物";
        case WORDS_CATEGORY_ANIMAL:
            return @"动物";
        case WORDS_CATEGORY_PLANT:
            return @"植物";
        case WORDS_CATEGORY_ELECTRONICS:
            return @"电子产品";
        case WORDS_CATEGORY_PERSON:
            return @"人物";
        case WORDS_CATEGORY_SPROT:
            return @"运动";
        default:
            return @"其他";
    }
}

- (NSArray *)getWordsArrayByCategoryId:(NSNumber*)categoryIdValue
{
    NSMutableArray *wordsArray = [[[NSMutableArray alloc] init] autorelease];
    
    NSArray *allWords = [self getAllWords];
    
    for (Words *words in allWords) {
        if ([words.categoryId isEqual:categoryIdValue]) {
            [wordsArray addObject:words];
        }
    }
    
    return wordsArray;
}

@end
