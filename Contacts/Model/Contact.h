//
//  Contact.h
//  Contacts
//
//  Created by Scire Studios on 5/7/15.
//  Copyright (c) 2015 Diego Rincon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *job;
@property (nonatomic, assign, readonly) NSInteger ID;
@property (nonatomic, assign) NSInteger phoneNumber;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *address;

// Designated initializer
- (instancetype)initWithID:(NSInteger)ID;

- (instancetype)initWithID:(NSInteger)ID name:(NSString *)name;

- (instancetype)initWithID:(NSInteger)ID name:(NSString *)name lastName:(NSString *)lastName;

- (instancetype)initWithID:(NSInteger)ID name:(NSString *)name phoneNumber:(NSInteger)phoneNumber;

@end
