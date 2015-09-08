//
//  ZENEditorWrapperView.h
//  Zen
//
//  Created by Wojciech Czekalski on 23.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// In order to resolve some dependencies IDE classes climb up through the view hierarchy. They look up for a view which responds to the -viewController methods and call it on them in order to get the dependency. Check out ./Reverse Engineering/IDEKit for more info.

@interface ZENEditorWrapperView : NSView

@property (nonatomic, weak, readonly) NSViewController *viewController;

- (instancetype)initWithViewController:(NSViewController *)viewController;

@end
