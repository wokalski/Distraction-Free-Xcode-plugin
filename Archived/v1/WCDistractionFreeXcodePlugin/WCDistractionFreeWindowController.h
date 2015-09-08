//
//  WCDistractionFreeWindowController.h
//  WCDistractionFreeXcodePlugin
//
//  Created by Wojciech Czekalski on 06.01.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class IDEWorkspaceDocument;

@interface WCDistractionFreeWindowController : NSWindowController
- (instancetype)initWithWindow:(NSWindow *)window document:(IDEWorkspaceDocument *)document;
- (void)setWorkspaceDocumentLocal:(IDEWorkspaceDocument *)doc;
@end
