//
//  GradientLayerDelegate.h
//  CoreAnimationTest
//
//  Created by hugues on 04/09/15.
//  Copyright © 2015 hugues. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface GradientLayerDelegate : NSObject

@property (nonatomic, strong) CALayer * gradientlayer;
@property (nonatomic) float radius;

@end
