//
//  ConfigureManager.m
//  GhostGame
//
//  Created by  on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ConfigureManager.h"
#import "Words.h"
#define KEY_PASSWORD @"KEY_PASSWORD"
#define KEY_LASTUSED_WORDS @"KEY_LASTUSED_WORDS"
#define KEY_HAVE_SOUND @"KEY_HAVE_SOUND"
#define KEY_IS_DEFAULT_TIPS @"KEY_IS_TIPS"

@implementation ConfigureManager

+ (NSString *)valueForKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:key];
}

+ (void)setValue:(NSString *)value forKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

+ (NSString *)getPassword
{
    return [ConfigureManager valueForKey:KEY_PASSWORD];
}

+ (void)setPassword:(NSString *)password
{
    [ConfigureManager setValue:password forKey:KEY_PASSWORD];
}

+ (void)setHaveSound:(BOOL)haveSound
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:haveSound forKey:KEY_HAVE_SOUND];
}

+ (BOOL)getHaveSoung
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:KEY_HAVE_SOUND]) {
        return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_HAVE_SOUND];
    }
    else{
        return YES;  //default have sound
    }
}

+ (void)setIsDefaultTips:(BOOL)isDefaultTips
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isDefaultTips forKey:KEY_IS_DEFAULT_TIPS];
}

+ (BOOL)getIsDefaultTips
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:KEY_IS_DEFAULT_TIPS]) {
        return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_IS_DEFAULT_TIPS];
    }
    else{
        return YES;  //default show default tips
    }
}

@end
