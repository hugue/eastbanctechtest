//
//  ViewController.h
//  HelloWorld
//
//  Created by hugues on 19/08/15.
//  Copyright (c) 2015 hugues. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
    int state;
}

@property (weak, nonatomic) IBOutlet UILabel *message;

- (IBAction)button1:(id)sender;

@end

