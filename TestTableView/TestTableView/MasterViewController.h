//
//  MasterViewController.h
//  TestTableView
//
//  Created by hugues on 20/08/15.
//  Copyright (c) 2015 hugues. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@import MediaPlayer;

#import "DetailViewController.h"
#import "Country.h"
#import "CountryAccessController.h"
#import "CountryTableViewCell.h"
#import "ConnectionController.h"
#import "CountrySearchController.h"
#import "CountrySearchControllerDelegate.h"

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, CountrySearchControllerDelegate, ConnectionControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@property (nonatomic, strong) ConnectionController * connectionController;
//@property (nonatomic, strong) UISearchController * searchController;
@property (nonatomic, strong) CountrySearchController * countrySearchController;

- (IBAction)reloadValues:(id)sender;
@end

