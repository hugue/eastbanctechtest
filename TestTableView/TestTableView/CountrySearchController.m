//
//  SearchController.m
//  TestTableView
//
//  Created by hugues on 28/08/15.
//  Copyright © 2015 hugues. All rights reserved.
//

#import "CountrySearchController.h"

@implementation CountrySearchController

@synthesize searchResults;
@synthesize countries;

- (id) init {
    self = [super init];
    if (self) {
        self.searchController = [[UISearchController alloc]
                                 initWithSearchResultsController:nil];        
    }
    return self;
}

- (void) configureSearchController {
    self.searchController.searchResultsUpdater = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    
    self.searchController.definesPresentationContext = YES;
    [self.searchController.searchBar sizeToFit];
}

#pragma mark - UISearchResultsUpdating methods

- (void) updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
    
    NSString * searchString = self.searchController.searchBar.text;
    [self searchForText: searchString];
    if([self.delegate respondsToSelector:@selector(updateSearchResults)]) {
        [self.delegate updateSearchResults];
    }
}

- (void) searchForText: (NSString *) text {
    
    [self.delegate giveDataToSearchIn];
    [self.searchResults removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",text];
    self.searchResults = [NSMutableArray arrayWithArray:[self.countries filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchBar delegate methods

@end
