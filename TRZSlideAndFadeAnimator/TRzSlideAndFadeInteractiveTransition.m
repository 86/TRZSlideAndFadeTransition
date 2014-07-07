//
//  TRzSlideAndFadeInteractiveTransition.m
//  TRZSlideAndFadeAnimator
//
//  Created by yam on 2014/06/29.
//  Copyright (c) 2014年 86. All rights reserved.
//

#import "TRzSlideAndFadeInteractiveTransition.h"


@implementation TRzSlideAndFadeInteractiveTransition

    CGPoint stPoint;
    bool opposite;

- (void)setView:(UIView *)view
{
    _view = view;
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:gesture];
}


- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            NSLog(@"UIGestureRecognizerStateBegan");
//            self.interactive = YES;
//            CGPoint point = [recognizer locationInView:self.view];
            opposite = NO;
            stPoint = [recognizer locationInView:self.view];
            NSLog(@"stPoint:%f, %f",stPoint.x, stPoint.y);
//            [self.delegate interactiveTransition:self interactionBeganAtPoint:point];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
//            NSLog(@"UIGestureRecognizerStateChanged");
            CGPoint translation = [recognizer translationInView:self.view];
//            NSLog(@"tlPoint:%f, %f",translation.x, translation.y);
            if (!self.interactive) {
                if (translation.x < 0) {
                    NSLog(@"tlPoint:%f, %f",translation.x, translation.y);
                    NSLog(@"opposite:YES!");
                    opposite = YES;
                }
                self.interactive = YES;
                [self.delegate interactiveTransition:self interactionBeganAtPoint:stPoint opposite:opposite];
            } else {
                CGRect viewRect = self.view.bounds;
                CGFloat percent = translation.x / CGRectGetWidth(viewRect);
//                NSLog(@"updateInteractiveTransition:percent:%f",percent);
//                NSLog(@"updateInteractiveTransition:fabs(percent):%f",fabsf(percent));
                [self updateInteractiveTransition:fabsf(percent)];
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"UIGestureRecognizerStateEnded");
            CGPoint translation = [recognizer translationInView:self.view];
            CGRect viewRect = self.view.bounds;
            CGFloat percent = translation.x / CGRectGetWidth(viewRect);
            CGPoint velocity = [recognizer velocityInView:self.view];
            if (fabs(percent) < 0.3) {
                [self cancelInteractiveTransition];
            } else {
                if (!opposite) {
                    if (velocity.x > 0) {
                        [self finishInteractiveTransition];
                    } else {
                        [self cancelInteractiveTransition];
                    }
                } else {
                    if (velocity.x > 0) {
                        [self cancelInteractiveTransition];
                    } else {
                        [self finishInteractiveTransition];
                    }
                }
            }
            self.interactive = NO;
            break;
        }
        case UIGestureRecognizerStateCancelled:
        default:
            break;
    }
}


@end
