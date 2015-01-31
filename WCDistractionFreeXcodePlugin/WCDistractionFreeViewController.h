//
//  WCDistractionFreeViewController.h
//  WCDistractionFreeXcodePlugin
//
//  Created by Wojciech Czekalski on 08.01.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class IDESourceCodeDocument, IDEFileTextSettings, IDEWorkspaceTabController, IDEEditorContext;

@interface WCDistractionFreeViewController : NSViewController
@property (nonatomic, strong) IDESourceCodeDocument *sourceCodeDocument;
@property (nonatomic, strong) IDEFileTextSettings *textSettings;
@property (nonatomic, strong) IDEWorkspaceTabController *tabController;
@property (nonatomic, strong) IDEEditorContext *editorContext;
@end