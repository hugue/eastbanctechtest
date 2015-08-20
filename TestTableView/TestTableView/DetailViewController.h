//
//  DetailViewController.h
//  TestTableView
//
//  Created by hugues on 20/08/15.
//  Copyright (c) 2015 hugues. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Country;
@interface DetailViewController : UIViewController

@property (strong, nonatomic) Country * detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *countryFlag;

@end

