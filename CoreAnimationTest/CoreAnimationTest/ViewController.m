//
//  ViewController.m
//  CoreAnimationTest
//
//  Created by hugues on 03/09/15.
//  Copyright © 2015 hugues. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CABasicAnimation * animation;

@property (nonatomic, strong) CAShapeLayer * circle;
@property (nonatomic, strong) CALayer * rainbowLayer;

@property (nonatomic, strong) GradientLayerDelegate * gradientLayerDelegate;

@property (nonatomic, strong) UIBezierPath * pathClockWise;
@property (nonatomic, strong) UIBezierPath * pathCounterClockWise;
@property (nonatomic, strong) UIBezierPath * pathForRainbow;

@end

@implementation ViewController

int animationState = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createAnimations];
    [self drawShape];
    self.gradientLayerDelegate = [[GradientLayerDelegate alloc] init];
    [self createGradientLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAnimation:(id)sender {
    if (self.rainbowLayer.superlayer) {
        [self.rainbowLayer removeFromSuperlayer];
    }
    
    self.animationButton.enabled = NO;
    [self.view.layer addSublayer:self.circle];
    [self.circle addAnimation:self.animation forKey:@"drawDiskAnimation"];
}

- (void) drawShape {
    CGRect mainRect = self.view.layer.bounds;
    NSLog(@"Size : %f and %f", mainRect.size.width, mainRect.size.height);
    NSLog(@"origin : x : %f y : %f", mainRect.origin.x, mainRect.origin.y);
    self.radius = CGRectGetWidth(mainRect);

    self.pathClockWise = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*_radius, 2.0*_radius) cornerRadius:_radius];
    self.pathCounterClockWise = [[self.pathClockWise copy] bezierPathByReversingPath];

    self.circle = [CAShapeLayer layer];
    
    self.circle.path = self.pathClockWise.CGPath;
    
    self.circle.position = CGPointMake(CGRectGetMidX(self.view.frame) - _radius, CGRectGetMidY(self.view.frame) - _radius);
    
    self.circle.fillColor = [UIColor clearColor].CGColor;
    self.circle.strokeColor = [UIColor orangeColor].CGColor;
    //self.circle.backgroundColor = [UIColor orangeColor].CGColor;
    self.circle.lineWidth = 2*_radius;
    self.circle.fillRule = kCAFillRuleEvenOdd;
}

- (void) createAnimations {
    //Configure Animation
    self.animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    self.animation.duration = 5.0;
    self.animation.repeatCount = 1.0;
    self.animation.fromValue = @0;
    self.animation.toValue = @1;
    self.animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    self.animation.delegate = self;
}

- (void) animationDidStop:(nonnull CAAnimation *)anim finished:(BOOL)flag {
    
    //red display
    if (animationState == 0) {
        animationState++;
        self.view.backgroundColor = [UIColor orangeColor];
        self.circle.strokeColor = [UIColor redColor].CGColor;
        [self.circle addAnimation:self.animation forKey:@"drawDiskAnimation2"];
     }
    //rainbow display
    else if (animationState == 1) {
        animationState++;
        self.view.backgroundColor = [UIColor redColor];
        [self.view.layer addSublayer:self.rainbowLayer];
        [self.rainbowLayer setNeedsDisplay];
        self.animation.fromValue = @1;
        self.animation.toValue = @0;
        self.circle.path = self.pathCounterClockWise.CGPath;
        [self.circle addAnimation: self.animation forKey:@"Uncover animation"];
        
    }
    else if (animationState == 2) {
        //back to normal
        self.animationButton.enabled = YES;
        animationState = 0;
        self.animation.fromValue = @0;
        self.animation.toValue = @1;
        self.circle.strokeColor = [UIColor orangeColor].CGColor;
        self.view.backgroundColor = [UIColor whiteColor];
        self.circle.path = self.pathClockWise.CGPath;
        [self.circle removeFromSuperlayer];
    }
}

- (void) createGradientLayer {
    self.rainbowLayer = [CALayer layer];
    
    self.rainbowLayer.delegate = self.gradientLayerDelegate;
    self.gradientLayerDelegate.gradientlayer = self.rainbowLayer;
    self.gradientLayerDelegate.radius = 2*self.radius;
    
    self.rainbowLayer.frame = CGRectMake(0,0, 2*self.radius , 2*self.radius);
    self.rainbowLayer.position = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    self.rainbowLayer.zPosition = -1;
}

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    self.rainbowLayer.position = CGPointMake(CGRectGetMidY(self.view.frame), CGRectGetMidX(self.view.frame));
    self.circle.position = CGPointMake(CGRectGetMidY(self.view.frame) - _radius, CGRectGetMidX(self.view.frame) - _radius);
}
@end
