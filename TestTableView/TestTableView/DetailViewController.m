//
//  DetailViewController.m
//  TestTableView
//
//  Created by hugues on 20/08/15.
//  Copyright (c) 2015 hugues. All rights reserved.
//

#import "DetailViewController.h"
#import "Country.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField * activeField;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void) registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
      
        self.nameText.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.currencyText.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        self.nameText.tag = 0;
        self.currencyText.tag = 1;
        
        self.currencyText.text = self.detailItem.currency;
        self.nameText.text = self.detailItem.name;
        self.countryFlag.image = [UIImage imageNamed:self.detailItem.pathToImage];

        self.nameText.delegate = self;
        self.currencyText.delegate = self;
        
        [self registerForKeyboardNotifications];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
      [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void) keyboardWillBeShown: (NSNotification *) aNotification {
    
    NSDictionary * info = [aNotification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    self.scrollInfo.contentInset = contentInsets;
    self.scrollInfo.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    CGPoint point = CGPointMake(self.activeField.frame.origin.x+self.activeField.frame.size.width, self.activeField.frame.origin.y+self.activeField.frame.size.height);
    if(!CGRectContainsPoint(aRect, point)) {
       [self.scrollInfo setContentOffset:CGPointMake(0.0, self.activeField.frame.origin.y
                                                    - aRect.size.height + self.activeField.frame.size.height)
                                                    animated:YES];
    }
    
}

- (void) keyboardWillBeHidden:(NSNotification *) aNotification {
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollInfo.contentInset = contentInsets;
    self.scrollInfo.scrollIndicatorInsets = contentInsets;
}

- (void) textFieldDidBeginEditing: (UITextField *) textField {
    self.activeField = textField;
}


- (void) textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 0) {
        //self.detailItem.name = [textField.text copy];
        [self.detailItem.name setString: textField.text];
    }
    else if (textField.tag == 1) {
        [self.detailItem.currency setString: textField.text];
    }
    
    self.activeField = nil;
}

#pragma mark UIImagePickerControllerDelegate methods

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString * documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * uniqueFilename = [[NSUUID UUID] UUIDString];
    NSString * imagePath = [documentsDirectory stringByAppendingPathComponent:uniqueFilename];
    
    UIImage * image = [info objectForKey: UIImagePickerControllerEditedImage];
    
    [UIImagePNGRepresentation (image) writeToFile:imagePath atomically:YES];

    [self.detailItem.pathToImage setString:imagePath];
    [self dismissViewControllerAnimated:YES completion:nil];
    self.countryFlag.image = [UIImage imageNamed:self.detailItem.pathToImage];
}


- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Button hidden in the image to change it
- (IBAction)changePicture:(id)sender {
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet * photoSourceSheet = [[UIActionSheet alloc] initWithTitle: @"Select New Image"
                                                                       delegate:self
                                                                       cancelButtonTitle:@"Cancel"
                                                                       destructiveButtonTitle:nil
                                                                       otherButtonTitles:@"Take a Picture",@"Choose in Library", nil];
        [photoSourceSheet showFromRect:((UIButton *)sender).frame inView:self.view animated:YES];
    }
    else {
     
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
    }
}

//Choose between taking a new picture or select one in the Library
- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    switch (buttonIndex) {
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        default:;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}


@end
