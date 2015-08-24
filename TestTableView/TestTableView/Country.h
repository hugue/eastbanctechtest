//
//  Country.h
//  TestTableView
//
//  Created by hugues on 20/08/15.
//  Copyright (c) 2015 hugues. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject

@property (nonatomic, strong) NSMutableString * name;
@property (nonatomic, strong) NSMutableString * pathToImage;
@property (nonatomic, strong) NSMutableString * currency;

- (id) initWithName: (NSString *)name andImage: (NSString *) pathToImage andCurrency : (NSString *) currency;

@end
