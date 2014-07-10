//
//  TRZSlideAndFadeAnimatedTransiton.h
//  TRZSlideAndFadeTransition
//
//  Created by yam on 2014/07/01.
//  Copyright (c) 2014年 86. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TRZInteractionDirection) {
    TRZInteractionDirectionRight,
    TRZInteractionDirectionLeft
};

@interface TRZSlideAndFadeAnimatedTransiton : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic) BOOL dismiss;
@property (nonatomic) TRZInteractionDirection interactionDirection;

@end
