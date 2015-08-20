//
//  CountryAccessController.m
//  TestTableView
//
//  Created by hugues on 20/08/15.
//  Copyright (c) 2015 hugues. All rights reserved.
//

#import "CountryAccessController.h"
#import "Country.h"

@interface CountryAccessController()
@property (nonatomic, readonly) NSMutableArray * countryList;

- (void) initializeDefaultCountries;

@end

@implementation CountryAccessController

- (id) init {
    self = [super init];
    
    if(self != nil) {
        _countryList = [[NSMutableArray alloc] init];
        [self initializeDefaultCountries];
        
        return self;
    }
    return nil;
}

- (void) initializeDefaultCountries {
    
    [self addCountryWithName:@"France" andPathToImage: @"France.gif"];
    [self addCountryWithName:@"Italy" andPathToImage: @"images"];
    [self addCountryWithName:@"Spain" andPathToImage: @"Spain.jpeg"];
    [self addCountryWithName:@"United Kingdom" andPathToImage: @"uk.jpg"];
    [self addCountryWithName:@"Russie" andPathToImage: @"Russie.jpeg"];
}

- (void) addCountryWithName:(NSString *)name andPathToImage:(NSString *)pathToImage {
    
    Country * newCountry = [[Country alloc] initWithName:name andImage:pathToImage];
    [self.countryList addObject:newCountry];
}

- (void) removeCountryAtIndex:(NSUInteger) index {
    [self.countryList removeObjectAtIndex: index];    
}

- (Country *) CountryAtIndex:(NSUInteger)index {
    return [self.countryList objectAtIndex:index];
}

- (NSUInteger) CountryCount {
    return [self.countryList count];
}

- (Country *) getCountryAtIndex:(NSUInteger)index {
    return self.countryList[index];
}

- (void) insertCountry:(Country *)country AtIndex:(NSUInteger)index {
    [self.countryList insertObject: country atIndex: index];
}

@end
