//
//  WCWorkspaceProxy.h
//  WCDistractionFreeXcodePlugin
//
//  Created by Wojciech Czekalski on 09.03.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XcodeHeaders.h"

@interface WCWorkspaceProxy : NSProxy
@property (nonatomic, strong, readonly) IDEWorkspaceDocument *workspaceDocument;
@property (nonatomic, strong, readonly) NSWindowController *windowController;

- (instancetype)initWithWorkspace:(IDEWorkspace *)workspace workspaceDocument:(IDEWorkspaceDocument *)workspaceDocument windowController:(NSWindowController *)windowController;
@end
