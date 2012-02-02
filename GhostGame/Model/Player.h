//
//  Player.h
//  GhostGame
//
//  Created by gamy on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Player : NSObject {
    
}

@property(nonatomic, assign) NSInteger type;
@property(nonatomic, assign, getter = isAlive) BOOL alive;
@property(nonatomic, retain) NSString *word;

@end
