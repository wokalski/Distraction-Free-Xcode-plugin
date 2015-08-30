//
//  ZENBarsController.m
//  Zen
//
//  Created by Wojciech Czekalski on 28.07.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "ZENBarsController.h"
#import "XcodeViewControllers.h"
#import "IDEEditorContext.h"
#import "ZENContainerView.h"
@import ObjectiveC;

@implementation IDEEditorContext (ZENNavBar)
@dynamic navBar;
@dynamic sidebarView;
@end

@interface ZENBarsController ()
@property (nonatomic, strong) ZENContainerView *maskView;
@end

@implementation ZENBarsController

- (instancetype)initWithEditorContext:(IDEEditorContext *)editorContext backgroundColor:(NSColor *)backgroundColor
{
    self = [super init];
    
    if (self) {
        _editorContext = editorContext;
        _backgroundColor = backgroundColor;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.maskView.frame = self.editorContext.sidebarView.frame;
}

- (void)hideBars
{
    DVTTextSidebarView *sidebarView = self.editorContext.sidebarView;
    
    [self.maskView removeFromSuperview];
    self.maskView = [self maskViewForSidebar:sidebarView];
    [sidebarView.superview addSubview:self.maskView];
    
    [sidebarView addObserver:self forKeyPath:[self boundsKeyPath] options:0 context:NULL];
    
    CGRect editorBounds = self.editorContext.view.bounds;
    
    IDESourceCodeEditor *editor = self.editorContext.editor;
    NSSize inset = editor.textView.textContainerInset;
    inset.height += self.editorContext.navBar.frame.size.height;
    editor.textView.textContainerInset = inset;
    
    self.editorContext.editor.view.superview.frame = editorBounds;
    self.editorContext.editor.view.frame = editorBounds;
    
    self.editorContext.navBar.alphaValue = 0.f;
}

- (void)showBars
{
    CGFloat targetAlpha = 1.f;
    
    CGRect editorBounds = self.editorContext.view.frame;
    CGFloat navBarHeight = self.editorContext.navBar.frame.size.height;
    
    editorBounds.size.height -= navBarHeight;
    
    IDESourceCodeEditor *editor = self.editorContext.editor;
    NSSize inset = editor.textView.textContainerInset;
    inset.height -= self.editorContext.navBar.alphaValue == 0 ? self.editorContext.navBar.frame.size.height : 01 ;
    editor.textView.textContainerInset = inset;
    
    self.editorContext.editor.view.superview.frame = editorBounds;
    self.editorContext.editor.view.frame = editorBounds;
    
    self.editorContext.navBar.alphaValue = targetAlpha;
    [self.maskView removeFromSuperview];
}

- (ZENContainerView *)maskViewForSidebar:(DVTTextSidebarView *)sidebarView
{
    ZENContainerView *containerView = [[ZENContainerView alloc] initWithFrame:sidebarView.frame];
    containerView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    containerView.backgroundColor = self.backgroundColor;
    return containerView;
}

+ (void)load
{
    const char *navBarEncodingString = method_getTypeEncoding(class_getInstanceMethod([IDEEditorContext class], @selector(navBar)));
    const char *sidebarViewEncodingString = method_getTypeEncoding(class_getInstanceMethod([IDEEditorContext class], @selector(sidebarView)));
    
    
    // Done this way, instead of category in case this method exists in future versions of Xcode
    class_addMethod([IDEEditorContext class], @selector(navBar), [self navBarGetterIMP], navBarEncodingString);
    class_addMethod([IDEEditorContext class], @selector(sidebarView), [self sidebarGetterIMP], sidebarViewEncodingString);
    
}

+ (IMP)navBarGetterIMP
{
    return imp_implementationWithBlock(^IDENavBar *(IDEEditorContext *self) {
        return [self valueForKey:@"_navBar"];
    });
}

+ (IMP)sidebarGetterIMP
{
    return imp_implementationWithBlock(^DVTTextSidebarView *(IDEEditorContext *self) {
        return [[self editor] valueForKey:@"_sidebarView"]; // It assumes that the current editor is a code editor.
    });
}

#pragma mark - KVO

- (void)dealloc
{
    [self.editorContext.sidebarView removeObserver:self forKeyPath:[self boundsKeyPath]];
}

- (NSString *)boundsKeyPath
{
    return NSStringFromSelector(@selector(frame));
}

@end
