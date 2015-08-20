//
//  MasterViewController.m
//  TestTableView
//
//  Created by hugues on 20/08/15.
//  Copyright (c) 2015 hugues. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Country.h"
#import "CountryAccessController.h"

@interface MasterViewController ()

@property (nonatomic, strong) CountryAccessController * countryAccessController;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.countryAccessController = [[CountryAccessController alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//   self.navigationItem.leftBarButtonItem = self.editButtonItem;

//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}*/

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showCountryDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Country * country = [self.countryAccessController CountryAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:country];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.countryAccessController CountryCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CountryCell" forIndexPath:indexPath];

    Country * country = [self.countryAccessController CountryAtIndex:indexPath.row];
    cell.textLabel.text = country.name;
    cell.imageView.image = [UIImage imageNamed: country.pathToImage];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.countryAccessController removeCountryAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    Country * countryToMove = [self.countryAccessController getCountryAtIndex:sourceIndexPath.row];
    [self.countryAccessController removeCountryAtIndex:sourceIndexPath.row];
    [self.countryAccessController insertCountry:countryToMove AtIndex:sourceIndexPath.row];
}

- (BOOL) tableView: (UITableView *) tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSIndexPath *) tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    return proposedDestinationIndexPath;
}

- (IBAction)edit:(id)sender {
    if ([self.instruction.titleLabel.text isEqualToString:@"Edit"]) {
    [self setEditing:YES animated:YES];
    [self.instruction setTitle:@"Done" forState: UIControlStateNormal];
    }
    else {
        [self setEditing:NO animated:YES];
        [self.instruction setTitle:@"Edit" forState: UIControlStateNormal];
    }
}
@end
