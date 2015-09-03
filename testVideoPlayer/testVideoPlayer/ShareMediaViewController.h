//
//  ShareMediaViewController.h
//  testVideoPlayer
//
//  Created by hugues on 01/09/15.
//  Copyright © 2015 hugues. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>

#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <CoreFoundation/CoreFoundation.h>


@interface ShareMediaViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) ALAsset * mediaAsset;

-(BOOL)startMediaBrowserFromViewController:(UIViewController*)controller usingDelegate:(id )delegate;


- (IBAction)performSharing:(id)sender;

@end
