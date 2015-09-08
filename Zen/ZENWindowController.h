//
//  ZENWindowController.h
//  Zen
//
//  Created by Wojciech Czekalski on 19.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZENIDEEditorContextDependencyManager.h"

@interface ZENWindowController : NSWindowController <NSWindowDelegate>

/**
 * This property just exists to make Open Quickly dialog work with Zen. All unrecognized selectors received by the window are forwarded to the dependency manager.
*/

@property (nonatomic, strong) ZENIDEEditorContextDependencyManager *dependencyManager;

- (instancetype)initWithWindow:(NSWindow *)window dependencyManager:(ZENIDEEditorContextDependencyManager *)dependencyManager;

@end
