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

+ (NSString *)getPassword;
+ (void)setPassword:(NSString *)password;

@end
