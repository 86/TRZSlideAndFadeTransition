//
//  TRZSlideAndFadeInteractiveTransition.h
//  TRZSlideAndFadeTransition
//
//  Created by yam on 2014/06/29.
//  Copyright (c) 2014年 86. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TRZSlideAndFadeInteractiveTransitionDelegate <NSObject>

- (void)startInteraction:(id <UIViewControllerInteractiveTransitioning>)transition direction:(BOOL)direction;

@end

@interface TRZSlideAndFadeInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, weak) id <TRZSlideAndFadeInteractiveTransitionDelegate> delegate;
@property (nonatomic) UIView *view;
@property (nonatomic) BOOL interactive;

@end
