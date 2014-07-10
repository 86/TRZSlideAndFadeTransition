//
//  TRZSlideAndFadeAnimatedTransiton.m
//  TRZSlideAndFadeTransition
//
//  Created by yam on 2014/07/01.
//  Copyright (c) 2014年 86. All rights reserved.
//

#import "TRZSlideAndFadeAnimatedTransiton.h"

@implementation TRZSlideAndFadeAnimatedTransiton

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
//    NSLog(@"animateTranstion");
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    UIView *containerView = [transitionContext containerView];
    CGRect bgnFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect endFrame;
    CGFloat angle = 4.0 * M_PI / 180.0;
//    NSLog(@"fromView:%@",NSStringFromCGRect(fromView.frame));
//    NSLog(@"toView:%@",NSStringFromCGRect(toView.frame));
//    NSLog(@"containerView:%@",NSStringFromCGRect(containerView.frame));
//    NSLog(@"bgnFrame:%@",NSStringFromCGRect(bgnFrame));
    
    switch (_interactionDirection) {
        case TRZInteractionDirectionRight:
//            NSLog(@"interactionDirectionRight");
            endFrame = CGRectOffset(bgnFrame, CGRectGetWidth(bgnFrame), 20);
            break;
        case TRZInteractionDirectionLeft:
//            NSLog(@"interactionDirectionLeft");
            endFrame = CGRectOffset(bgnFrame, -CGRectGetWidth(bgnFrame), 20);
            angle = -angle;
            break;
        default:
            break;
    }
//    NSLog(@"endFrame:%@",NSStringFromCGRect(endFrame));
    
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
             [transitionContext completeTransition:completed];
         }];
    }
}

- (void)animationEnded:(BOOL)transitionCompleted {
//    NSLog(@"-> animationEnded:%d",transitionCompleted);
}


@end
