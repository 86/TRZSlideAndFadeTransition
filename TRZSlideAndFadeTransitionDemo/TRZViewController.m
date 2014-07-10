//
//  TRZViewController.m
//  TRZSlideAndFadeTransition
//
//  Created by yam on 2014/06/29.
//  Copyright (c) 2014年 86. All rights reserved.
//

#import "TRZViewController.h"
#import "TRZSlideAndFadeInteractiveTransition.h"
#import "TRZSlideAndFadeAnimatedTransiton.h"
#import "TRZModalViewController.h"

@interface TRZViewController () <UIViewControllerTransitioningDelegate, TRZSlideAndFadeInteractiveTransitionDelegate >

@property (nonatomic) TRZSlideAndFadeInteractiveTransition *interactiveTransition;
@property (nonatomic) TRZSlideAndFadeAnimatedTransiton *animatedTransition;

@end

@implementation TRZViewController

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
    TRZSlideAndFadeAnimatedTransiton *animatedTransition = [[TRZSlideAndFadeAnimatedTransiton alloc] init];
    animatedTransition.dismiss = YES;
    self.animatedTransition = animatedTransition;
    return self.animatedTransition;
}



#pragma mark - UIViewControllerInteractiveTransitioning

- (id <UIViewControllerInteractiveTransitioning>)interactionContollerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    if (self.interactiveTransition != nil && self.interactiveTransition.interactive) {
        return self.interactiveTransition;
    }
    return nil;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"openView"]) {
//        NSLog(@"prepareForSegue");
        TRZModalViewController *controller = segue.destinationViewController;
        
        controller.transitioningDelegate = self;
        controller.modalPresentationStyle = UIModalPresentationFullScreen;
        
        self.interactiveTransition = [[TRZSlideAndFadeInteractiveTransition alloc] init];
        self.interactiveTransition.view = controller.view;
        self.interactiveTransition.delegate = self;
    }
}


#pragma mark - TRzSlideAndFadeInteractiveTransitionDelegate

- (void)startInteraction:(id<UIViewControllerInteractiveTransitioning>)transition direction:(BOOL)direction {
    [self dismissViewControllerAnimated:YES completion:nil];
    self.animatedTransition.interactionDirection = direction;
}

@end