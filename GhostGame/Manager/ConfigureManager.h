//
//  ConfigureManager.h
//  GhostGame
//
//  Created by  on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Words;

@interface ConfigureManager : NSObject
{
    
}

+ (void)setPassword:(NSString *)password;
+ (NSString *)getPassword;
+ (void)setHaveSound:(BOOL)haveSound;
+ (BOOL)getHaveSoung;
+ (void)setIsDefaultTips:(BOOL)isDefaultTips;
+ (BOOL)getIsDefaultTips;
@end
