//
//  ViewControllerOrientation.h
//  testVideoPlayer
//
//  Created by hugues on 01/09/15.
//  Copyright © 2015 hugues. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewController (Orientation)

- (UIInterfaceOrientationMask) supportedInterfaceOrientations;
- (BOOL) shouldAutorotate;
- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation;

@end
