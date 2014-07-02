//
//  TRzViewController.m
//  TRZSlideAndFadeAnimator
//
//  Created by yam on 2014/06/29.
//  Copyright (c) 2014年 86. All rights reserved.
//

#import "TRzViewController.h"
#import "TRzSlideAndFadeInteractiveTransition.h"
#import "TRzSlideAndFadeAnimatedTransiton.h"
#import "TRzModalViewController.h"

@interface TRzViewController () <UIViewControllerTransitioningDelegate, TRzSlideAndFadeInteractiveTransitionDelegate >

@property (nonatomic) TRzSlideAndFadeInteractiveTransition *interactiveTransition;
@property (nonatomic) TRzSlideAndFadeAnimatedTransiton *animatedTransition;

@end

@implementation TRzViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIViewControllerAnimatedTransitioning

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source {
    return nil;
}

-(id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    TRzSlideAndFadeAnimatedTransiton *animatedTransition = [[TRzSlideAndFadeAnimatedTransiton alloc] init];
    animatedTransition.dismiss = YES;
    self.animatedTransition = animatedTransition;
    return self.animatedTransition;
}



#pragma mark - UIViewControllerInteractiveTransitioning

- (id <UIViewControllerInteractiveTransitioning>)interactionContollerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    if (self.interactiveTransition != nil && self.interactiveTransition.isInteractive) {
        return self.interactiveTransition;
    }
    return nil;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"openView"]) {
//        NSLog(@"prepareForSegue");
        TRzModalViewController *controller = segue.destinationViewController;
        
        controller.transitioningDelegate = self;
        controller.modalPresentationStyle = UIModalPresentationFullScreen;
        
        self.interactiveTransition = [[TRzSlideAndFadeInteractiveTransition alloc] init];
        self.interactiveTransition.view = controller.view;
        self.interactiveTransition.delegate = self;
    }
}


#pragma mark - TRzSlideAndFadeInteractiveTransitionDelegate

- (void)interactiveTransition:(id<UIViewControllerInteractiveTransitioning>)transition interactionBeganAtPoint:(CGPoint)point opposite:(BOOL)opposite {
    NSLog(@"interactiveTransition:interactionBeganAtPoint:opposite:%d",opposite);
    [self dismissViewControllerAnimated:YES completion:nil];
    self.animatedTransition.opposite = opposite;
}
    
    
@end