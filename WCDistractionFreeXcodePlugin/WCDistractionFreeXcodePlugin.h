//
//  WCDistractionFreeXcodePlugin.h
//  WCDistractionFreeXcodePlugin
//
//  Created by Wojciech Czekalski on 25.12.2014.
//  Copyright (c) 2014 Wojciech Czekalski. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface WCDistractionFreeXcodePlugin : NSObject

+ (instancetype)sharedPlugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end