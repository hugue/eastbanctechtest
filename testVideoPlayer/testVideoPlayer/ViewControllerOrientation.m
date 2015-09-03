//
//  ViewControllerOrientation.m
//  testVideoPlayer
//
//  Created by hugues on 01/09/15.
//  Copyright © 2015 hugues. All rights reserved.
//

#import "ViewControllerOrientation.h"

@implementation UIViewController (Orientation)

- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;  
}

- (BOOL) shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
