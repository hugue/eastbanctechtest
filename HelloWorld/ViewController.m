//
//  ViewController.m
//  HelloWorld
//
//  Created by hugues on 19/08/15.
//  Copyright (c) 2015 hugues. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button1:(id)sender {
    if ([self.message.text isEqualToString:@"Push the button"]) {
        self.message.text = @"Hello World !";
    }
    else {
        self.message.text = @"Push the button";
    }
}
@end
