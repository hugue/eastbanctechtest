//
//  CountryTableViewCell.h
//  TestTableView
//
//  Created by hugues on 21/08/15.
//  Copyright (c) 2015 hugues. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CountryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *countryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryCurrencyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *countryFlag;
@property (weak, nonatomic) IBOutlet UILabel *currencyValueLabel;

@end
