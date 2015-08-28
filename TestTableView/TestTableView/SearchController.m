//
//  SearchController.m
//  TestTableView
//
//  Created by hugues on 28/08/15.
//  Copyright © 2015 hugues. All rights reserved.
//

#import "SearchController.h"

@implementation SearchController

@synthesize searchResults;
@synthesize countries;

- (id) initWithDelegate: (MasterViewController *) delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.searchResults = [NSMutableArray arrayWithCapacity:[self.countries count]];
       
        self.searchController = [[UISearchController alloc]
                                 initWithSearchResultsController:self.delegate];
        self.searchController.searchResultsUpdater = self;
        self.searchController.delegate = self;
        self.searchController.dimsBackgroundDuringPresentation = NO;
        self.searchController.searchBar.delegate = self;
        self.delegate.tableView.tableHeaderView = self.searchController.searchBar;
        self.definesPresentationContext = YES;
    }
    return self;
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.searchResults removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    self.searchResults = [NSMutableArray arrayWithArray:[self.countries filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchResultsUpdating methods

- (void) updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
    
    [self filterContentForSearchText:searchController.searchBar.text];
}

@end
