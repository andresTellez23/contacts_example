//
//  ViewController.m
//  Contacts
//
//  Created by Scire Studios on 5/7/15.
//  Copyright (c) 2015 Diego Rincon. All rights reserved.
//

#import "ViewController.h"
#import "Contact.h"
#import "DataBaseManager.h"
#import "DetailsViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) UIBarButtonItem *addContactButtonItem;
@property (nonatomic, strong) DetailsViewController *detailsVC;

@end

@implementation ViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Contactos";
    self.navigationItem.rightBarButtonItem = self.addContactButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.contactsTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setters and getters

- (UIBarButtonItem *)addContactButtonItem
{
    if (_addContactButtonItem == nil) {
        
        _addContactButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didTapAddButtonItem:)];
    }
    
    return _addContactButtonItem;
}

- (DetailsViewController *)detailsVC
{
    if (_detailsVC == nil) {
        
        _detailsVC = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
    }
    
    return _detailsVC;
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[DataBaseManager sharedManager] getNumberOfContacts];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ContactInfoTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contact *contact = [[DataBaseManager sharedManager].contacts objectAtIndex:indexPath.row];
    
//    DataBaseManager *dbMananger = [DataBaseManager sharedManager];
//    NSArray *contacts = dbMananger.contacts;
//    NSInteger index = indexPath.row;
//    Contact *contact2 = [contacts objectAtIndex:index];
    
    NSString *text;
    
    if (![contact.name isEqualToString:@""] && ![contact.lastName isEqualToString:@""]) {
        
        text = [NSString stringWithFormat:@"%@ %@", contact.name, contact.lastName];
    }
    else if (![contact.name isEqualToString:@""]) {
        
        text = contact.name;
    }
    else {
        
        text = contact.lastName;
    }
    
    cell.textLabel.text = text;
    
    NSString *detailText = @"";
    
    if (contact.phoneNumber > 0) {
        
        detailText = [NSString stringWithFormat:@"%ld", (long)contact.phoneNumber];
    }
    else {
        
        detailText = contact.job;
    }
    
    cell.detailTextLabel.text = detailText;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contact *contact = [[DataBaseManager sharedManager].contacts objectAtIndex:indexPath.row];
    
    self.detailsVC.editMode = EditMode_None;
    self.detailsVC.contact = contact;
    
    [self.navigationController pushViewController:self.detailsVC
                                         animated:YES];
}

#pragma mark - Action methods

// didTapAddButtonItem:
- (void)didTapAddButtonItem:(UIBarButtonItem *)buttonItem
{
    self.detailsVC.editMode = EditMode_New;
    self.detailsVC.contact = nil;
    
    [self.navigationController pushViewController:self.detailsVC
                                         animated:YES];
}

@end
