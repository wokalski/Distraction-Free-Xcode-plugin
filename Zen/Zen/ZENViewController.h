//
//  ZENViewController.h
//  Zen
//
//  Created by Wojciech Czekalski on 15.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZENInterfaceController.h"

@protocol ZENEditorLayout <NSObject>

- (CGRect)editorRectInBounds:(CGRect)bounds;

@end


@interface ZENViewController : NSViewController

@property (nonatomic, strong, readonly) NSColor *backgroundColor;
@property (nonatomic, strong, readonly) id<ZENEditorLayout> layout;
@property (nonatomic, strong, readonly) NSViewController *editorViewController;
@property (nonatomic, strong, readonly) id<ZENInterfaceController> interfaceController;

- (instancetype)initWithEditorViewController:(NSViewController *)editorViewController layout:(id<ZENEditorLayout>)layout backgroundColor:(NSColor *)backgroundColor interfaceController:(id<ZENInterfaceController>)interfaceController __attribute__((nonnull));

@end
