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

@end
