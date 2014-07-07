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
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"animateTranstion");
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    UIView *containerView = [transitionContext containerView];
//    NSLog(@"fromView:%@",NSStringFromCGRect(fromView.frame));
//    NSLog(@"toView:%@",NSStringFromCGRect(toView.frame));
//    NSLog(@"containerView:%@",NSStringFromCGRect(containerView.frame));
    
    CGRect bgnFrame = [transitionContext initialFrameForViewController:fromVC];
//    NSLog(@"bgnFrame:%@",NSStringFromCGRect(bgnFrame));
    CGRect endFrame;
    CGFloat angle = 4.0 * M_PI / 180.0;
//    NSLog(@"opposite:%d",self.opposite);
    if (self.opposite) {
//        NSLog(@"moveForOpposite");
        endFrame = CGRectOffset(bgnFrame, -CGRectGetWidth(bgnFrame), 20);
//        NSLog(@"endFrame:%@",NSStringFromCGRect(endFrame));
        angle = -angle;
    } else {
        endFrame = CGRectOffset(bgnFrame, CGRectGetWidth(bgnFrame), 20);
//        NSLog(@"endFrame:%@",NSStringFromCGRect(endFrame));
    }
    if (self.dismiss) {
        [containerView insertSubview:toView belowSubview:fromView];
        toView.frame = bgnFrame;
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             fromView.frame = endFrame;
                             fromView.alpha = 0.2;
                             fromView.transform = CGAffineTransformMakeRotation(angle);
                         }
         completion:^(BOOL finished){
             BOOL completed = ![transitionContext transitionWasCancelled];
//             NSLog(@"completeTransition:%@",NSStringFromCGRect(fromVC.view.frame));
             [transitionContext completeTransition:completed];
         }];
    }
}

- (void)animationEnded:(BOOL)transitionCompleted {
    NSLog(@"animationEnded:%d",transitionCompleted);
}


@end
