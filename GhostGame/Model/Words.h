//
//  Words.h
//  GhostGame
//
//  Created by haodong qiu on 12年2月6日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Words : NSObject

@property(nonatomic, retain)NSString *civilianWord;
@property(nonatomic, retain)NSString *foolWord;

- (id)initWithCivilianWord:(NSString *)civilianWordValue 
                  foolWord:(NSString *)foolWordValue;

@end
