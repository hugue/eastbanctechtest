//
//  MasterViewController.h
//  TestTableView
//
//  Created by hugues on 20/08/15.
//  Copyright (c) 2015 hugues. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController

- (IBAction)edit:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *instruction;

@end

