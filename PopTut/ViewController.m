// I made this quick project to help you get started with the Pop framework
// This animation is something I created for Tapity's Hours app http://www.hourstimetracking.com
// I'll be posting more tutorials and such to http://www.tapity.com

#import "ViewController.h"

#import "POP/POP.h"

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
    
    POPSpringAnimation *buttonAnimation = [POPSpringAnimation animation];
    
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
    
    buttonAnimation.property = [POPAnimatableProperty propertyWithName:kPOPLayerSize];
    
    // These have to be objects so use NSNumber for single values and NSValue for multiple values (CGSize for two, CGRect for four)
    // Size has x and y values so we need two values, hence CGSize...
    if (_timerRunning) {
        buttonAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(37, 37)];
    }
    else {
        buttonAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(46, 46)];
    }
    
    
    //Set any relevant attributes
    
    // Basic: duration (CFTimeInterval)
    // Decay: duration (CFTimeInterval), velocity (NSValue), deceleration (CGFloat)
    // Spring: velocity (NSValue), springBounciness (CGFloat), springSpeed (CGFloat), dynamicsTension (CGFloat), dynamicsFriction (CGFloat), dynamicsMass (CGFloat)
    
    // Use bounciness / speed together. Only use values from 0 to 12
    buttonAnimation.springBounciness = 10.0;
    buttonAnimation.springSpeed = 10.0;
    
    // or for more advanced control
    //    popAnimation.dynamicsTension = 15.0;
    //    popAnimation.dynamicsFriction = 2.0;
    //    popAnimation.dynamicsMass = .2;
    
    //Add it to the target to play the animation for a unique key
    [_button pop_addAnimation:buttonAnimation forKey:@"pop"];
    
    
    /* SlideOut animation */
    
    POPSpringAnimation *popOutAnimation = [POPSpringAnimation animation];
    popOutAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    if (!_timerRunning) {
        popOutAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(245, 70, 0, 10)];
        // It is not a good idea to use absolute values like this but it makes it easier to demo
    }
    else {
        popOutAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(180, 60, 75, 26)];
    }
    
    popOutAnimation.velocity = [NSValue valueWithCGRect:CGRectMake(200, 0, 300, -200)];
    popOutAnimation.springBounciness = 10.0;
    popOutAnimation.springSpeed = 10.0;
    
    [_popOut pop_addAnimation:popOutAnimation forKey:@"slide"];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
