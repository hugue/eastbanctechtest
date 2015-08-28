//
//  MasterViewController.m
//  TestTableView
//
//  Created by hugues on 20/08/15.
//  Copyright (c) 2015 hugues. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()

@property (nonatomic, strong) CountryAccessController * countryAccessController;
@property (nonatomic, strong) NSFetchedResultsController * countryListController;

@end


@implementation MasterViewController

@synthesize managedObjectContext;
@synthesize countryListController;

- (void) awakeFromNib {
    [super awakeFromNib];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:self.editButtonItem,self.navigationItem.leftBarButtonItem, nil];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
   
    NSError * error;
    if(![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);
    }
    self.title = @"Country";
}

- (void) viewDidUnload {
    self.countryListController = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Initializes the fetchController
- (NSFetchedResultsController *)fetchedResultsController {
    
    if (self.countryListController != nil) {
        return self.countryListController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Country" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey: @"displayOrder" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                managedObjectContext:managedObjectContext sectionNameKeyPath:nil
                                                                                                cacheName:@"Root"];
    self.countryListController = theFetchedResultsController;
    self.countryListController.delegate = self;
    
    return self.countryListController;
    
}

- (void)insertNewObject:(id)sender {
    
    NSManagedObjectContext * context = [self managedObjectContext];
    NSMutableArray * countries = [[self.countryListController fetchedObjects] mutableCopy];
    
    Country * newCountry = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"Country"
                                    inManagedObjectContext:self.managedObjectContext];
    newCountry.displayOrder =  0;
    newCountry.currencyValue = 0;
    newCountry.name         = [@"name" mutableCopy];
    newCountry.currency     = [@"currency" mutableCopy];
    newCountry.pathToImage  = [@"defaultImage" mutableCopy];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    // Now insert newCountry at the destination.
    [countries insertObject:newCountry atIndex:[indexPath row]];
    
    // All of the objects are now in their correct order. Update each
    // object's displayOrder field by iterating through the array.
    int i = 0;
    for (NSManagedObject * mo in countries)
    {
        [mo setValue:[NSNumber numberWithInt:i] forKey:@"displayOrder"];
        i++;
    }
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

- (IBAction)reloadValues:(id)sender {
    [self.connectionController launchSession];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showCountryDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        /**Old Code with CountryAccessController
        Country * country = [self.countryAccessController CountryAtIndex:indexPath.row];*/
        Country * country = [self.countryListController objectAtIndexPath:indexPath];
        [[segue destinationViewController] setDetailItem:country];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [self.countryAccessController CountryCount];
    id sectionInfo = [[self.countryListController sections] objectAtIndex: section];
    return [sectionInfo numberOfObjects];
}

- (void)configureCell:(CountryTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    Country * country = [self.countryListController objectAtIndexPath:indexPath];
    cell.countryNameLabel.text = country.name;
    cell.countryCurrencyLabel.text = country.currency;
    cell.countryFlag.image = [UIImage imageNamed:country.pathToImage];
    cell.currencyValueLabel.text = country.currencyValue;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CountryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CountryCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[CountryTableViewCell alloc] init];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [managedObjectContext deleteObject:[countryListController objectAtIndexPath:indexPath]];
        NSError *error;
        if (![managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // Grab the item we're moving.
    NSMutableArray * countries = [[self.countryListController fetchedObjects] mutableCopy];
    
    // Grab the item we're moving.
    NSManagedObject * countryToMove = [[self fetchedResultsController] objectAtIndexPath:sourceIndexPath];
    
    // Remove the object we're moving from the array.
    [countries removeObject: countryToMove];
    // Now re-insert it at the destination.
    [countries insertObject:countryToMove atIndex:[destinationIndexPath row]];
    
    // All of the objects are now in their correct order. Update each
    // object's displayOrder field by iterating through the array.
    int i = 0;
    for (Country * mo in countries)
    {
        [mo setValue:[NSNumber numberWithInt:i++] forKey:@"displayOrder"];
    }
   }

- (BOOL) tableView: (UITableView *) tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSIndexPath *) tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    return proposedDestinationIndexPath;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

//Delegate for the NSFetchResultsController object

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:{
            [tableView cellForRowAtIndexPath:indexPath];
            NSError *error;
            if (![managedObjectContext save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }

        }
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}

- (void) updateCurrencyValues:(NSDictionary *) newCurrencyValues {
    Country * country;
    for(country in [countryListController fetchedObjects]) {
        country.currencyValue = [[[newCurrencyValues objectForKey:country.currency] stringValue] mutableCopy];
    }
    [self.tableView reloadData];
}

#pragma mark - Connection Controller Delegate Methods


-  (void) parseData {
    NSError * error;
    NSLog(@"Will now parse the data");
    NSDictionary * webInfo = [NSJSONSerialization JSONObjectWithData: self.connectionController.receivedData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&error];
    NSDictionary * currencies = [webInfo objectForKey:@"rates"];
    [self updateCurrencyValues:currencies];
}

@end
