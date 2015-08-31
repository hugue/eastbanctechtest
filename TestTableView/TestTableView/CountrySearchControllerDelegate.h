//
//  CountrySearchControllerDelegate.h
//  TestTableView
//
//  Created by hugues on 31/08/15.
//  Copyright © 2015 hugues. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CountrySearchControllerDelegate <NSObject>

- (void) updateSearchResults;
- (void) giveDataToSearchIn;

@end
