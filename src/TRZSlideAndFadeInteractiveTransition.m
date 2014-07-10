//
//  TRZSlideAndFadeInteractiveTransition.m
//  TRZSlideAndFadeTransition
//
//  Created by yam on 2014/06/29.
//  Copyright (c) 2014年 86. All rights reserved.
//

#import "TRZSlideAndFadeInteractiveTransition.h"


@implementation TRZSlideAndFadeInteractiveTransition

    BOOL directionLeft;

- (void)setView:(UIView *)view
{
    _view = view;
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:gesture];
}


- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
//    CGPoint point = [recognizer locationInView:self.view];
    CGPoint translation = [recognizer translationInView:self.view];
    CGRect viewRect = self.view.bounds;
    CGFloat percent = translation.x / CGRectGetWidth(viewRect);
    CGPoint velocity = [recognizer velocityInView:self.view];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
//            NSLog(@"UIGestureRecognizerStateBegan");
            directionLeft = NO;
//            NSLog(@"stPoint:%f, %f",point.x, point.y);
            break;
        case UIGestureRecognizerStateChanged:
//            NSLog(@"UIGestureRecognizerStateChanged");
//            NSLog(@"tlPoint:%f, %f",translation.x, translation.y);
            if (!self.interactive) {
                if (translation.x < 0) {
                    directionLeft = YES;
//                    NSLog(@"directionLeft");
                }
                self.interactive = YES;
                [self.delegate startInteraction:self direction:directionLeft];
            } else {
                if (!directionLeft) {
                    if (translation.x > 0) {
                        [self updateInteractiveTransition:fabsf(percent)];
                    } else {
                        [self updateInteractiveTransition:0.0];
                    }
                } else {
                    if (translation.x < 0) {
                        [self updateInteractiveTransition:fabsf(percent)];
                    } else {
                        [self updateInteractiveTransition:0.0];
                    }
                }
//                NSLog(@"updateInteractiveTransition:percent:%f",percent);
            }
            break;
        case UIGestureRecognizerStateEnded:
//            NSLog(@"UIGestureRecognizerStateEnded");
            if (fabs(percent) < 0.3) {
                [self cancelInteractiveTransition];
            } else {
                if (!directionLeft) {
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
        case UIGestureRecognizerStateCancelled:
            [self cancelInteractiveTransition];
            self.interactive = NO;
        default:
            break;
    }
}

@end
