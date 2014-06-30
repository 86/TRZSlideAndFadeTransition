//
//  TRzSlideAndFadeAnimatedTransiton.m
//  TRZSlideAndFadeAnimator
//
//  Created by yam on 2014/07/01.
//  Copyright (c) 2014年 86. All rights reserved.
//

#import "TRzSlideAndFadeAnimatedTransiton.h"

@implementation TRzSlideAndFadeAnimatedTransiton

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *contrainerView = [transitionContext containerView];
    
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect toFrame = CGRectOffset(fromFrame, CGRectGetWidth(fromFrame), 0);
    
    if (self.reverse) {
        [contrainerView insertSubview:toVC.view belowSubview:fromVC.view];
        toVC.view.frame = fromFrame;
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0.0
             usingSpringWithDamping:0.4
              initialSpringVelocity:1.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             fromVC.view.frame = toFrame;
                         }
         completion:^(BOOL finished){
             BOOL completed = ![transitionContext transitionWasCancelled];
             [transitionContext completeTransition:completed];
         }];
    }
}

@end
