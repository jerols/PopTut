/**
 Copyright (c) 2014-present, Facebook, Inc.
 All rights reserved.
 
 This source code is licensed under the BSD-style license found in the
 LICENSE file in the root directory of this source tree. An additional grant
 of patent rights can be found in the PATENTS file in the same directory.
 */

#import "ViewController.h"

#import <POP/POP.h>

@interface ViewController ()

@property (nonatomic, retain) UIView *button;
@property (nonatomic, retain) UIView *popOut;
@property (readwrite, assign) BOOL timerRunning;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _popOut = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TimerPopOut"]];
    [_popOut setFrame:CGRectMake(245, 70, 0, 0)];
    
    [self.view addSubview:_popOut];
    
    _button = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TimerButton"]];
    [_button setFrame:CGRectMake(240, 50, 46, 46)];
    [self.view addSubview:_button];
    

    
    _timerRunning = NO;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(demoAnimate:)]];
}


- (void)demoAnimate:(UITapGestureRecognizer*)tap
{
    _timerRunning = !_timerRunning;
    
    /* Timer enlarge / shrink animation
    I've spelled out the different options available in comments
    Feel free to delete them when you get it */
    
    /* Create the animation, choose from
    
    POPBasicAnimation (traditional) - defaultAnimation, linearAnimation, easeInAnimation, easeOutAnimation, easeInEaseOutAnimation
    
    POPDecayAnimation - animation, animationWithPropertyNamed:(NSString *)name;
    
    POPSpringAnimation (bouncy) - animation, animationWithPropertyNamed:(NSString *)name;
    
    POPCustomAnimation - advanced, for custom animation types */
    
    POPSpringAnimation *popAnimation = [POPSpringAnimation animation];
    
    /* Set the property that you want to animate, like...
    kPOPLayerBackgroundColor;
    kPOPLayerBounds;
    kPOPLayerPosition;
    kPOPLayerPositionX;
    kPOPLayerPositionY;
    kPOPLayerOpacity;
    kPOPLayerScaleX;
    kPOPLayerScaleY;
    kPOPLayerScaleXY;
    kPOPLayerTranslationX;
    kPOPLayerTranslationY;
    kPOPLayerTranslationZ;
    kPOPLayerTranslationXY;
    kPOPLayerSubscaleXY;
    kPOPLayerSubtranslationX;
    kPOPLayerSubtranslationY;
    kPOPLayerSubtranslationZ;
    kPOPLayerSubtranslationXY;
    kPOPLayerZPosition;
    kPOPLayerSize;
    kPOPLayerRotation;
    kPOPLayerRotationY;
    kPOPLayerRotationX;
    
    kPOPViewAlpha;
    kPOPViewBackgroundColor;
    kPOPViewBounds;
    kPOPViewCenter;
    kPOPViewFrame;
    kPOPViewScaleX;
    kPOPViewScaleXY;
    kPOPViewScaleY;
    kPOPViewSize; */
    
    popAnimation.property = [POPAnimatableProperty propertyWithName:kPOPLayerSize];
    
    // These have to be objects so use NSNumber for single values and NSValue for multiple values (CGSize for two, CGRect for four)
    // Size has x and y values so we need two values, hence CGSize...
    if (_timerRunning) {
        popAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(37, 37)];
    }
    else {
        popAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(46, 46)];
    }
    
    
    //Set any relevant attributes
    
    // Basic: duration (CFTimeInterval)
    // Decay: duration (CFTimeInterval), velocity (NSValue), deceleration (CGFloat)
    // Spring: velocity (NSValue), springBounciness (CGFloat), springSpeed (CGFloat), dynamicsTension (CGFloat), dynamicsFriction (CGFloat), dynamicsMass (CGFloat)
    
    // Use bounciness / speed together. Only use values from 0 to 12
    popAnimation.springBounciness = 10.0;
    popAnimation.springSpeed = 10.0;
    
    // or for more advanced control
//    popAnimation.dynamicsTension = 15.0;
//    popAnimation.dynamicsFriction = 2.0;
//    popAnimation.dynamicsMass = .2;
    
    //Add it to the target to play the animation for a unique key
    [_button pop_addAnimation:popAnimation forKey:@"pop"];
    

    /* SlideOut animation */
    
    POPSpringAnimation *slideAnimation = [POPSpringAnimation animation];
    slideAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    if (!_timerRunning) {
        slideAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(245, 70, 0, 10)];
        // It is not a good idea to use absolute values like this but it makes it easier to demo
    }
    else {
       slideAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(180, 60, 75, 26)];
    }
    
    slideAnimation.velocity = [NSValue valueWithCGRect:CGRectMake(200, 0, 300, -200)];
    slideAnimation.springBounciness = 10.0;
    slideAnimation.springSpeed = 10.0;

    [_popOut pop_addAnimation:slideAnimation forKey:@"slide"];
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
