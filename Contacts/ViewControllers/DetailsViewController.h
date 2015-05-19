//
//  DetailsViewController.h
//  Contacts
//
//  Created by Scire Studios on 5/12/15.
//  Copyright (c) 2015 Diego Rincon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Contact.h"

typedef NS_ENUM(NSInteger, EditMode)
{
    EditMode_None,
    EditMode_New,
    EditMode_Edit,
};

@interface DetailsViewController : UIViewController

@property (nonatomic, strong) Contact *contact;
@property (nonatomic, assign) EditMode editMode;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *jobTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;

@end
