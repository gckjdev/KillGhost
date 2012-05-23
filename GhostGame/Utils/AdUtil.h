//
//  AdUtil.h
//  GhostGame
//
//  Created by haodong qiu on 12年5月23日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GADBannerView;

@interface AdUtil : NSObject

+ (GADBannerView*)allocAdMobView:(UIViewController*)superViewController;

@end
