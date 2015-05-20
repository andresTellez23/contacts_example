//
//  Contact.m
//  Contacts
//
//  Created by Scire Studios on 5/7/15.
//  Copyright (c) 2015 Diego Rincon. All rights reserved.
//

#import "Contact.h"

@implementation Contact

- (instancetype)initWithID:(NSInteger)ID
{
    self = [super init];
    
    if (self) {
        
        _ID = ID;
        _name = @"";
        _lastName = @"";
        _job = @"";
        _phoneNumber = 0;
        _email = @"";
        _address = @"";
    }
    
    return self;
}

- (instancetype)initWithID:(NSInteger)ID name:(NSString *)name
{
    self = [self initWithID:ID];
    
    if (self) {
        
        _name = name;
    }
    
    return self;
}

- (instancetype)initWithID:(NSInteger)ID name:(NSString *)name lastName:(NSString *)lastName
{
    self = [self initWithID:ID name:name];
    
    if (self) {
        
        _lastName = lastName;
    }
    
    return self;
}

- (instancetype)initWithID:(NSInteger)ID name:(NSString *)name phoneNumber:(NSInteger)phoneNumber
{
    self = [self initWithID:ID name:name];
    
    if (self) {
        
        _phoneNumber = phoneNumber;
    }
    
    return self;
}

@end
