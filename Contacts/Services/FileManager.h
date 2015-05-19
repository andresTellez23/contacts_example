//
//  FileManager.h
//  Contacts
//
//  Created by Scire Studios on 5/15/15.
//  Copyright (c) 2015 Diego Rincon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileManager : NSObject

+ (void)writeImageToFile:(UIImage *)image withName:(NSString *)name;
+ (UIImage *)loadImageWithName:(NSString *)name;

@end
