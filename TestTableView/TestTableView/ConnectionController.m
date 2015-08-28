//
//  ConnectionController.m
//  TestTableView
//
//  Created by hugues on 27/08/15.
//  Copyright © 2015 hugues. All rights reserved.
//

#import "ConnectionController.h"

@interface ConnectionController ()

@property (nonatomic, strong) NSString * urlConnection;

@end

@implementation ConnectionController

#pragma mark NSURLConnection Delegate Methods

- (id) init {
    self = [super init];
    if(self) {
    self.urlConnection = @"https://openexchangerates.org/api/latest.json?app_id=163f3aee83664b77b1950e9c088c2d7b";
    }
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    self.receivedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [self.receivedData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    if ([self.delegate respondsToSelector:@selector(parseData)]) {
        [self.delegate parseData];
    }
    
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    connection = nil;
    self.receivedData = nil;
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

#pragma mark - NSURLSession delegate methods

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSData * data = [NSData dataWithContentsOfURL:location];
    self.receivedData = [data copy];
    [self.delegate parseData];
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    
}

#pragma mark - Connection data preocessing methods
- (void) launchConnection {
    //Create the request
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString: self.urlConnection]];
    NSURLConnection * conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(!conn) {
        NSLog(@"Can't open the connection");
    }
    
}

- (void) launchSession {
    self.receivedData = nil;
    NSURL *url = [NSURL URLWithString:self.urlConnection];
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    [session downloadTaskWithURL:url];
    NSURLSessionDownloadTask * downloadTask = [session downloadTaskWithURL:url];
    [downloadTask resume];
    if(!session) {
        NSLog(@"Can't open the connection");
    }
}

@end
