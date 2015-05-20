//
//  FileManager.m
//  Contacts
//
//  Created by Scire Studios on 5/15/15.
//  Copyright (c) 2015 Diego Rincon. All rights reserved.
//

#import "FileManager.h"

static NSString * const imageFolder = @"Profile_Images";

@implementation FileManager

+ (void)writeImageToFile:(UIImage *)image withName:(NSString *)name
{
    NSString *imagePath = [FileManager fullPathForImageWithName:name];
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    [imageData writeToFile:imagePath atomically:YES];
}

+ (UIImage *)loadImageWithName:(NSString *)name
{
    NSString *imagePath = [FileManager fullPathForImageWithName:name];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    UIImage *image = [UIImage imageWithData:imageData];
    
    return image;
}

+ (NSString *)fullPathForImageWithName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = paths.firstObject;
    NSString *imagePath = [documentsPath stringByAppendingPathComponent:imageFolder];
    
    BOOL imagesFolderExists = [[NSFileManager defaultManager] fileExistsAtPath:imagePath];
    
    if (imagesFolderExists == NO) {
        
        [[NSFileManager defaultManager] createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *imageName = [name stringByAppendingPathExtension:@"jpg"];
    NSString *imageFullPath = [imagePath stringByAppendingPathComponent:imageName];
    
    return imageFullPath;
}

@end
