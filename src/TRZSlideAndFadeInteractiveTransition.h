//
//  TRZSlideAndFadeInteractiveTransition.h
//  TRZSlideAndFadeTransition
//
//  Created by yam on 2014/06/29.
//  Copyright (c) 2014年 86. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TRZSlideAndFadeInteractiveTransitionDelegate;

@interface TRZSlideAndFadeInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, weak) id <TRZSlideAndFadeInteractiveTransitionDelegate> delegate;
@property (nonatomic) UIView *view;
@property (nonatomic, getter = isInteractive) BOOL interactive;

@end

@protocol TRZSlideAndFadeInteractiveTransitionDelegate <NSObject>

- (void)interactiveTransition:(id <UIViewControllerInteractiveTransitioning>)transition interactionBeganAtPoint:(CGPoint)point opposite:(BOOL)opposite;

@end
