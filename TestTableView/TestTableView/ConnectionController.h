//
//  ConnectionController.h
//  TestTableView
//
//  Created by hugues on 27/08/15.
//  Copyright © 2015 hugues. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConnectionController : NSObject <NSURLSessionDelegate, NSURLConnectionDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, strong) id delegate;
@property (nonatomic, strong) NSMutableData * receivedData;

- (void) launchConnection;
- (void) launchSession;
- (id) init;

@end

@protocol ConnectionControllerDelegate <NSObject>

- (void) parseData;

@end