//
//  MasterViewController.h
//  TestTableView
//
//  Created by hugues on 20/08/15.
//  Copyright (c) 2015 hugues. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, NSURLConnectionDelegate>

@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;

@end

