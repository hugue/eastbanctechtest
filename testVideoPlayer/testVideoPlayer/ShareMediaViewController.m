//
//  ShareMediaViewController.m
//  testVideoPlayer
//
//  Created by hugues on 01/09/15.
//  Copyright © 2015 hugues. All rights reserved.
//

#import "ShareMediaViewController.h"
#import <CoreFoundation/CoreFoundation.h>

@interface ShareMediaViewController ()
@property (nonatomic, strong) ALAssetsLibrary * library;

@end

@implementation ShareMediaViewController
@synthesize mediaAsset;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.library = [[ALAssetsLibrary alloc] init];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction) performSharing:(id)sender {
    
    
    
    if(([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No Saved Album Found"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        } else {
        [self startMediaBrowserFromViewController:self usingDelegate:self];
    }
}

- (BOOL) startMediaBrowserFromViewController:(UIViewController *)controller usingDelegate:(id)delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil)) {
        return NO;
    }
    
    UIImagePickerController * pickerController = [[UIImagePickerController alloc] init];
    pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString * )kUTTypeMovie, kUTTypeImage, nil];
    
    pickerController.allowsEditing = YES;
    pickerController.delegate = delegate;
    
    [controller presentViewController:pickerController animated:YES completion:nil];
    
    return YES;
}

- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info {
    
    NSString * mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    NSURL * path = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    BOOL conformsToImage = (UTTypeConformsTo((__bridge_retained CFStringRef) mediaType, kUTTypeImage));
    BOOL conformsToVideo = (UTTypeConformsTo((__bridge_retained CFStringRef) mediaType, kUTTypeAudiovisualContent));

                     
    [self dismissViewControllerAnimated:NO
        completion:^{
                                 
            if (conformsToImage) {
                UIImage * image = [info objectForKey: UIImagePickerControllerEditedImage];
                UIActivityViewController * controller = [[UIActivityViewController alloc] initWithActivityItems:@[image] applicationActivities:nil];
                [self presentViewController:controller animated:YES completion:nil];
            }
            else if (conformsToVideo) {
                
                [self.library assetForURL:path
                              resultBlock:^(ALAsset *asset) {
                                  NSLog(@"%@", path);
                                  ALAssetRepresentation* assetRepresentation = [asset defaultRepresentation];
                                  NSString* outputDirectory = [NSString stringWithFormat:@"%@", NSTemporaryDirectory()];
                                  NSString* pathToCopy = [outputDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", assetRepresentation.filename]];
                                 
                                  NSUInteger size = (NSUInteger)assetRepresentation.size;
                                  NSMutableData* data = [NSMutableData dataWithLength:size];
                                  
                                  NSUInteger bytesRead = [assetRepresentation getBytes:data.mutableBytes fromOffset:0 length:size error:nil];
                                  NSURL * url = nil;
                                  if ([data writeToFile:pathToCopy atomically:YES])
                                  {
                                      NSLog(@"Ok");
                                      url = [NSURL fileURLWithPath:pathToCopy];
                                      UIActivityViewController * controller = [[UIActivityViewController alloc] initWithActivityItems:@[url] applicationActivities:nil];
                                      [self presentViewController:controller animated:YES completion:nil];
                                  }
                              } failureBlock:^(NSError *error) {
                                  NSLog(@"Failure to use the ALAsset");
                    
                              }
                 ];
            }
        }
    ];
}

@end
