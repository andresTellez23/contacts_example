//
//  DataBaseManager.h
//  Contacts
//
//  Created by Scire Studios on 5/8/15.
//  Copyright (c) 2015 Diego Rincon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"

@interface DataBaseManager : NSObject

@property (nonatomic, strong, readonly) NSArray *contacts;

+ (DataBaseManager *)sharedManager;

- (void)insertContact:(Contact *)contact;
- (void)deleteContact:(Contact *)contact;
- (void)replaceContactWithID:(NSInteger)ID withContact:(Contact *)contact;
- (Contact *)getContactWithID:(NSInteger)ID;
- (NSInteger)getNumberOfContacts;
- (void)updateContacts;

@end
