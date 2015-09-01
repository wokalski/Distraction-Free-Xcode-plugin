//
//  ZENBarsController.h
//  Zen
//
//  Created by Wojciech Czekalski on 28.07.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

@import Cocoa;
#import "XcodeViews.h"
#import "IDEEditorContext.h"
#import "XcodeViewControllers.h"

@interface IDEEditorContext (ZENNavBar)
@property (nonatomic, readonly) IDENavBar *navBar;
@property (nonatomic, readonly) DVTTextSidebarView *sidebarView;
@end

@interface ZENBarsController : NSObject

@property (nonatomic, weak, readonly) IDEEditorContext *editorContext;
@property (nonatomic, strong, readonly) NSColor *backgroundColor;

- (instancetype)initWithEditorContext:(IDEEditorContext *)editorContext backgroundColor:(NSColor *)backgroundColor __attribute__((nonnull));

- (void)showBars;
- (void)hideBars;
- (NSTextView *)textViewInEditor:(IDEEditor *)editor;

@end
