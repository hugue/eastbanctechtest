//
//  Country.m
//  TestTableView
//
//  Created by hugues on 20/08/15.
//  Copyright (c) 2015 hugues. All rights reserved.
//

#import "Country.h"

@implementation Country

- (id) initWithName: (NSString *) name andImage:(NSString *)pathToImage;
{
    self = [super init];
    if(self != nil) {
        _name = name;
        _pathToImage = pathToImage;
        return self;
    }
    return nil;
}

@end
