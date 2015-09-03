//
//  RecordVideoViewController.h
//  testVideoPlayer
//
//  Created by hugues on 31/08/15.
//  Copyright © 2015 hugues. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RecordVideoViewController : UIViewController 

-(BOOL)startCameraControllerFromViewController:(UIViewController*)controller
                                 usingDelegate:(id )delegate;
-(void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void*)contextInfo;


- (IBAction)recordVideo:(id)sender;

@end
