//
//  DataBaseManager.m
//  Contacts
//
//  Created by Scire Studios on 5/8/15.
//  Copyright (c) 2015 Diego Rincon. All rights reserved.
//

#import "DataBaseManager.h"

@interface DataBaseManager ()

@property (nonatomic, strong, readwrite) NSArray *contacts;
@property (nonatomic, strong) NSMutableArray *mutableContacts;

@end

@implementation DataBaseManager

#pragma mark - Life cycle

+ (DataBaseManager *)sharedManager
{
    static DataBaseManager *instaceManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // Este codigo se ejecuta una sola vez
        instaceManager = [[DataBaseManager alloc] init];
    });
    
    return instaceManager;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        Contact *contact1 = [[Contact alloc] initWithID:1];
        contact1.lastName = @"Rincon";
        contact1.phoneNumber = 3155555555;
        Contact *contact2 = [[Contact alloc] initWithID:2 name:@"Oscar"];
        contact2.phoneNumber = 3156666666;
        contact2.job = @"Programador";
        Contact *contact3 = [[Contact alloc] initWithID:3 name:@"Germán"];
        contact3.phoneNumber = 3157777777;
        Contact *contact4 = [[Contact alloc] initWithID:4 name:@"Diana" lastName:@"Granados"];
        contact4.job = @"Programadora";
        Contact *contact5 = [[Contact alloc] initWithID:5 name:@"Reinner Steven"];
        contact5.phoneNumber = 3159999999;
        Contact *contact6 = [[Contact alloc] initWithID:6 name:@"Andrés" lastName:@"Tellez"];
        contact6.job = @"Estudiante";
        
        _mutableContacts = [@[contact1, contact2, contact3, contact4, contact5, contact6] mutableCopy];
        _contacts = [_mutableContacts copy];
    }
    
    return self;
}

#pragma mark - Public methods

- (void)insertContact:(Contact *)contact
{
    [self.mutableContacts addObject:contact];
    [self updateContacts];
}

- (void)deleteContact:(Contact *)contact
{
    [self.mutableContacts removeObject:contact];
    [self updateContacts];
}

- (void)replaceContactWithID:(NSInteger)ID withContact:(Contact *)contact
{
    Contact *originalContact = [self getContactWithID:ID];
    NSUInteger index = [self.mutableContacts indexOfObject:originalContact];
    
    [self.mutableContacts replaceObjectAtIndex:index withObject:contact];
    [self updateContacts];
}

- (Contact *)getContactWithID:(NSInteger)ID
{
    for (Contact *contact in self.mutableContacts) {
        
        if (contact.ID == ID) {
            
            return contact;
        }
    }
    
    return nil;
}

- (NSInteger)getNumberOfContacts
{
    return self.mutableContacts.count;
}

- (void)updateContacts
{
    self.contacts = [self.mutableContacts copy];
}

@end
