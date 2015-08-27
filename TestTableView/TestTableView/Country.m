//
//  Country.m
//  TestTableView
//
//  Created by hugues on 20/08/15.
//  Copyright (c) 2015 hugues. All rights reserved.
//

#import "Country.h"

@implementation Country

@dynamic pathToImage;
@dynamic name;
@dynamic currency;
@dynamic displayOrder;
@dynamic currencyValue;

- (id) initWithName: (NSString *) name andImage:(NSString *)pathToImage andCurrency: (NSString *) currency;
{
    self = [super init];
    if(self != nil) {
        self.name = [name mutableCopy];
        self.currency = [currency mutableCopy];
        self.pathToImage = [pathToImage mutableCopy];
        return self;
    }
    return nil;
}

@end
