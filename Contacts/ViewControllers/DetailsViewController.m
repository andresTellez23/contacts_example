//
//  DetailsViewController.m
//  Contacts
//
//  Created by Scire Studios on 5/12/15.
//  Copyright (c) 2015 Diego Rincon. All rights reserved.
//

#import "DetailsViewController.h"
#import "DataBaseManager.h"
#import "FileManager.h"

@interface DetailsViewController ()

@property (nonatomic, strong) UIBarButtonItem *saveButtonItem;
@property (nonatomic, strong) UIBarButtonItem *editContactButtonItem;
@property (nonatomic, strong) UIBarButtonItem *canelButtonItem;

@end

@implementation DetailsViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = self.contact.name;
    [self.profileImageView setImage:[UIImage imageNamed:@"profile_picture"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self enterEditableMode:self.editMode];
    [self loadContact:self.contact];
}

#pragma mark - Setters and getters

- (UIBarButtonItem *)saveButtonItem
{
    if (_saveButtonItem == nil) {
        
        _saveButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(didTapSaveButtonItem:)];
    }
    
    return _saveButtonItem;
}

- (UIBarButtonItem *)canelButtonItem
{
    if (_canelButtonItem == nil) {
        
        _canelButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(didTapCancelButtonItem:)];
    }
    
    return _canelButtonItem;
}

- (UIBarButtonItem *)editContactButtonItem
{
    if (_editContactButtonItem == nil) {
        
        _editContactButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(didTapEdiContactButtonItem:)];
    }
    
    return _editContactButtonItem;
}

#pragma mark - Action methods

- (void)didTapSaveButtonItem:(UIBarButtonItem *)buttonItem
{
    Contact *contact;
    
    if (self.editMode == EditMode_New) {
        
        contact = [[Contact alloc] initWithID:[[DataBaseManager sharedManager] getNumberOfContacts] + 1];
    }
    else {
        
        contact = self.contact;
    }
    
    contact.name = self.nameTextField.text;
    contact.lastName = self.lastNameTextField.text;
    contact.phoneNumber = self.phoneNumberTextField.text.integerValue;
    contact.job = self.jobTextField.text;
    contact.email = self.emailTextField.text;
    contact.address = self.addressTextField.text;
    
    self.contact = contact;
    
    if (self.editMode == EditMode_New) {
        
        [[DataBaseManager sharedManager] insertContact:contact];
    }
    else {
        
        [[DataBaseManager sharedManager] replaceContactWithID:self.contact.ID withContact:self.contact];
    }
    
    
    [self enterEditableMode:EditMode_None];
}

- (void)didTapCancelButtonItem:(UIBarButtonItem *)buttonItem
{
    if (self.editMode == EditMode_New) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        
        [self loadContact:self.contact];
        [self enterEditableMode:EditMode_None];
    }
}

- (void)didTapEdiContactButtonItem:(UIBarButtonItem *)buttonItem
{
    [self enterEditableMode:EditMode_Edit];
}

#pragma mark - Auxiliary methods

- (void)enterEditableMode:(EditMode)editMode
{
    self.editMode = editMode;
    
    BOOL enabled = (editMode == EditMode_Edit || editMode == EditMode_New);
    
    self.nameTextField.enabled = enabled;
    self.lastNameTextField.enabled = enabled;
    self.phoneNumberTextField.enabled = enabled;
    self.jobTextField.enabled = enabled;
    self.emailTextField.enabled = enabled;
    self.addressTextField.enabled = enabled;
    
    if (enabled) {
        
        self.navigationItem.leftBarButtonItem = self.canelButtonItem;
        self.navigationItem.rightBarButtonItem = self.saveButtonItem;
    }
    else {
        
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = self.editContactButtonItem;
    }
}

- (void)loadContact:(Contact *)contact
{
    NSString *imageName = [NSString stringWithFormat:@"%ld", (long)contact.ID];
    
    UIImage *profileImage = [FileManager loadImageWithName:imageName];
    
    if (profileImage == nil) {
        
        profileImage = [UIImage imageNamed:@"profile_picture"];
    }
    
    [self.profileImageView setImage:profileImage];
    self.nameTextField.text = contact.name;
    self.lastNameTextField.text = contact.lastName;
    self.phoneNumberTextField.text = [NSString stringWithFormat:@"%ld", (long)contact.phoneNumber];
    self.jobTextField.text = contact.job;
    self.emailTextField.text = contact.email;
    self.addressTextField.text = contact.address;
}

@end
