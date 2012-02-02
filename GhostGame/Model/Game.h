//
//  Game.h
//  GhostGame
//
//  Created by gamy on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Game : NSObject {

}

@property(nonatomic, assign)NSInteger ghostNumber;
@property(nonatomic, assign)NSInteger civilianNumber;
@property(nonatomic, assign)NSInteger foolNumber;

@property(nonatomic, assign)NSInteger retainGhostNumber;
@property(nonatomic, assign)NSInteger retainCivilianNumber;
@property(nonatomic, assign)NSInteger retainFoolNumber;

@property(nonatomic, assign)NSString *ghostWord;
@property(nonatomic, assign)NSString *civilianWord;
@property(nonatomic, assign)NSString *foolWord;


- (id)initWithGhostNumber:(NSInteger)ghostNumber 
                ghostWord:(NSString *)ghostWord 
           civilianNumber: (NSInteger)civilianNumber 
             civilianWord:(NSString *)civilianWord 
               foolNumber:(NSInteger)foolNumber
                 foolWord:(NSString *)foolWord;
@end
