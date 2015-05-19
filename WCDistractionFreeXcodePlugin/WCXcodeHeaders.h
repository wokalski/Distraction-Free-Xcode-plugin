//
//  WCXcodeHeaders.h
//  WCDistractionFreeXcodePlugin
//
//  Created by Wojciech Czekalski on 10.01.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WCXcodeModels.h"
#import "WCXcodeViews.h"
#import "WCXcodeViewControllers.h"
#import "IDEEditorContext.h"

@protocol IDEWorkspaceDocumentProvider <NSObject>
@property(readonly) IDEWorkspaceDocument *workspaceDocument;
@end
