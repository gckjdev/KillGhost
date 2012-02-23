//
//  Words.h
//  GhostGame
//
//  Created by haodong qiu on 12年2月6日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <Foundation/Foundation.h>

//enum category
//{
//    WORDS_CATEGORY_FOOD,    //食物
//    WORDS_CATEGORY_ANIMAL,  //动物
//    WORDS_CATEGORY_PLANT,   //植物
//    WORDS_CATEGORY_ELECTRONICS,  //电子产品
//    WORDS_CATEGORY_PERSON,       //人物
//    WORDS_CATEGORY_SPROT,        //运动
//    WORDS_CATEGORY_OTHER = 50    //其他
//};

@interface Words : NSObject<NSCoding>
{
    NSString *_category;
    NSString *_civilianWord;
    NSString *_foolWord;
}
@property(nonatomic, retain)NSString *category;
@property(nonatomic, retain)NSString *civilianWord;
@property(nonatomic, retain)NSString *foolWord;

- (id)initWithCivilianWord:(NSString *)civilianWordValue 
                  foolWord:(NSString *)foolWordValue 
                category:(NSString *)categoryValue;

- (BOOL)isEqualToWords:(Words *)words;
@end
