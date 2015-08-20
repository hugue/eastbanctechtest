//
//  CountryAccessController.h
//  TestTableView
//
//  Created by hugues on 20/08/15.
//  Copyright (c) 2015 hugues. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Country;

@interface CountryAccessController : NSObject

- (NSUInteger) CountryCount;

- (Country *) CountryAtIndex: (NSUInteger) index;

- (void) addCountryWithName: (NSString *) name
              andPathToImage: (NSString *) pathToImage;

- (void) removeCountryAtIndex: (NSUInteger) index;

- (Country *) getCountryAtIndex:(NSUInteger) index;

-(void) insertCountry:(Country *) country AtIndex:(NSUInteger) index;

@end
