//
//  WCDistractionFreeViewController.h
//  WCDistractionFreeXcodePlugin
//
//  Created by Wojciech Czekalski on 08.01.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WCEditorConfiguration, WCEditorLayout;

@interface WCDistractionFreeEditorController : NSViewController
@property (nonatomic, strong) WCEditorConfiguration *configuration;
@property (nonatomic, strong) WCEditorLayout *layout;
@end