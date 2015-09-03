//
//  ViewController.h
//  testVideoPlayer
//
//  Created by hugues on 31/08/15.
//  Copyright © 2015 hugues. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) MPMoviePlayerController * player;
@property (nonatomic, weak) NSString * pathToMovie;

@end

