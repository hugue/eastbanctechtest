//
//  SearchController.h
//  TestTableView
//
//  Created by hugues on 28/08/15.
//  Copyright © 2015 hugues. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CountrySearchControllerDelegate.h"


@interface CountrySearchController : NSObject <UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic, strong) NSArray * countries;
@property (nonatomic, strong) NSMutableArray * searchResults;
@property (strong, nonatomic) UISearchController * searchController;
@property (nonatomic, strong) id delegate;

- (id) init;
- (void) configureSearchController;

@end

