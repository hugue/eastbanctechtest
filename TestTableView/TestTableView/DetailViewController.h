//
//  DetailViewController.h
//  TestTableView
//
//  Created by hugues on 20/08/15.
//  Copyright (c) 2015 hugues. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Country;
@interface DetailViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) Country * detailItem;

@property (weak, nonatomic) IBOutlet UIImageView * countryFlag;
@property (weak, nonatomic) IBOutlet UITextField * nameText;
@property (weak, nonatomic) IBOutlet UITextField * currencyText;
@property (weak, nonatomic) IBOutlet UIScrollView * scrollInfo;

@property (weak, nonatomic) IBOutlet UIButton *changeImageButton;

- (IBAction)changePicture:(id)sender;

@end
