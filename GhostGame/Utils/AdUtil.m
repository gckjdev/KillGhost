//
//  AdUtil.m
//  GhostGame
//
//  Created by haodong qiu on 12年5月23日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "AdUtil.h"
#import "GADBannerView.h"
#import "MobClick.h"

#define PUBLISHER_ID    @"a14fbb61c7391c6"

#define ENABLE_AD           @"ENABLE_AD"
#define VALUE_ENABLE        @"1"
#define VALUE_NOT_ENABLE    @"0"

@implementation AdUtil

+ (GADBannerView*)allocAdMobView:(UIViewController*)superViewController
{
    // Create a view of the standard size at the bottom of the screen.
    GADBannerView* bannerView_ = [[GADBannerView alloc]
                                  initWithFrame:CGRectMake(0.0,
                                                           0,
                                                           GAD_SIZE_320x50.width,
                                                           GAD_SIZE_320x50.height)];
    
    // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
    bannerView_.adUnitID = PUBLISHER_ID;
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = superViewController;
    [superViewController.view addSubview:bannerView_];
    
    // Initiate a generic request to load it with an ad.
    [bannerView_ loadRequest:[GADRequest request]]; 
    
    if ([[MobClick getConfigParams:ENABLE_AD] isEqualToString:VALUE_NOT_ENABLE]) {
        bannerView_.hidden = YES;
    }else if ([[MobClick getConfigParams:ENABLE_AD] isEqualToString:VALUE_ENABLE]) {
        bannerView_.hidden = NO;
    }else {
        bannerView_.hidden = NO;
    }
    
    return bannerView_;
}



@end
