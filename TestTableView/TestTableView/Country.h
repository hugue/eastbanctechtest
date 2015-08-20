//
//  Country.h
//  TestTableView
//
//  Created by hugues on 20/08/15.
//  Copyright (c) 2015 hugues. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject

@property (nonatomic) NSString * name;
@property (nonatomic) NSString * pathToImage;

- (id) initWithName: (NSString *)name andImage: (NSString *) pathToImage;

@end
