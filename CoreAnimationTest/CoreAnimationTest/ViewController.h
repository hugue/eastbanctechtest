//
//  ViewController.h
//  CoreAnimationTest
//
//  Created by hugues on 03/09/15.
//  Copyright © 2015 hugues. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GradientLayerDelegate.h"

@interface ViewController : UIViewController

- (IBAction)startAnimation:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton * animationButton;

@property (nonatomic) CGFloat radius;

@end

