//
//  SearchController.h
//  TestTableView
//
//  Created by hugues on 28/08/15.
//  Copyright © 2015 hugues. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MasterViewController.h"

@interface SearchController : NSObject <UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic, strong) NSArray * countries;
@property (nonatomic, strong) NSMutableArray * searchResults;
@property (strong, nonatomic) UISearchController * searchController;
@property (nonatomic, strong) MasterViewController * delegate;

- (id) initWithDelegate: (MasterViewController *) delegate;

@end
@protocol SearchControllerDelegate <NSObject>


@end