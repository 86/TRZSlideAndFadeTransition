//
//  TRzSlideAndFadeInteractiveTransition.h
//  TRZSlideAndFadeTransition
//
//  Created by yam on 2014/06/29.
//  Copyright (c) 2014年 86. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TRzSlideAndFadeInteractiveTransitionDelegate;

@interface TRzSlideAndFadeInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, weak) id <TRzSlideAndFadeInteractiveTransitionDelegate> delegate;
@property (nonatomic) UIView *view;
@property (nonatomic, getter = isInteractive) BOOL interactive;

@end

@protocol TRzSlideAndFadeInteractiveTransitionDelegate <NSObject>

- (void)interactiveTransition:(id <UIViewControllerInteractiveTransitioning>)transition interactionBeganAtPoint:(CGPoint)point opposite:(BOOL)opposite;

@end
