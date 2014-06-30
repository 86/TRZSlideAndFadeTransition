//
//  TRzSlideAndFadeInteractiveTransition.m
//  TRzSlideAndFadeInteractiveTransition
//
//  Created by yam on 2014/06/29.
//  Copyright (c) 2014年 86. All rights reserved.
//

#import "TRzSlideAndFadeInteractiveTransition.h"

@implementation TRzSlideAndFadeInteractiveTransition


- (void)setView:(UIView *)view
{
    _view = view;
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:gesture];
}


- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    NSLog(@"handlePan");
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            NSLog(@"UIGestureRecognizerStateBegan:");
            self.interactive = YES;
            CGPoint point = [recognizer locationInView:self.view];
            [self.delegate interactiveTransition:self interactionBeganAtPoint:point];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            NSLog(@"UIGestureRecognizerStateChanged:");
            CGRect viewRect = self.view.bounds;
            CGPoint translation = [recognizer translationInView:self.view];
            CGFloat percent = translation.x / CGRectGetWidth(viewRect);
            [self updateInteractiveTransition:percent];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            NSLog(@"UIGestureRecognizerStateCancelled&Ended");
            CGPoint velocity = [recognizer velocityInView:self.view];
            if (velocity.x <= 0) { // 右から左へ移動中
                [self cancelInteractiveTransition];
            } else { // 左から右に移動中
                [self finishInteractiveTransition];
            }
            self.interactive = NO;
            break;
        }
        default:
            break;
    }
}


@end
