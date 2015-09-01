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
    if ([keyPath isEqualTo:ZENWindowKeypath()]) {
        NSView *view = object;
        if (view.window == nil) {
            [view removeObserver:self forKeyPath:ZENWindowKeypath()];
            [view removeObserver:self forKeyPath:ZENFrameKeypath()];
        }
    } else {
        self.maskView.frame = self.editorContext.sidebarView.frame ;
    }
}

- (void)hideBars
{
    IDENavBar *navBar = self.editorContext.navBar;
    NSView *snapshotView = [self snapshotOfView:navBar];
    
    [self.editorContext.navBar.superview addSubview:snapshotView];
    
    DVTTextSidebarView *sidebarView = self.editorContext.sidebarView;
    
    [sidebarView addObserver:self forKeyPath:ZENFrameKeypath() options:0 context:NULL];
    [sidebarView addObserver:self forKeyPath:ZENWindowKeypath() options:0 context:NULL];
    
    ZENContainerView *maskView = [self maskViewForSidebar:sidebarView];
    maskView.alphaValue = 0.f;
    maskView.frame = sidebarView.frame;
    [sidebarView.superview addSubview:maskView];
    self.maskView = maskView;
    
    [self adjustEditorToFrame:self.editorContext.view.frame];
    
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = .3;
        snapshotView.animator.alphaValue = 0;
        maskView.animator.alphaValue = 1;
    } completionHandler:^{
        self.editorContext.navBar.hidden = YES;
        [snapshotView removeFromSuperview];
    }];
}

- (void)showBars
{
    IDENavBar *navBar = self.editorContext.navBar;
    NSView *snapshotView;

    
    if (navBar.hidden == YES) {
        snapshotView = [self snapshotOfView:navBar];
    
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
            context.duration = 0.3;
            [self.maskView.animator removeFromSuperview];
            self.maskView = nil;
            [self.editorContext.view.superview.animator addSubview:snapshotView];
        
        } completionHandler:^{
            CGFloat navBarHeight = self.editorContext.navBar.frame.size.height;
            CGRect editorBounds = self.editorContext.view.frame;
            editorBounds.size.height -= navBarHeight;
            
            [self adjustEditorToFrame:editorBounds];
            navBar.hidden = NO;
            [snapshotView removeFromSuperview];
        
        }];
    }
}

- (void)adjustEditorToFrame:(CGRect)frame
{
    NSView *editorView = self.editorContext.editor.view;
    NSTextView *textView = [self textViewInEditor:self.editorContext.editor];
    
    CGFloat verticalScrollPositionDelta = -(CGRectGetHeight(frame) - CGRectGetHeight(editorView.frame));
    
    [self adjustYScrollPositionInScrollView:textView.enclosingScrollView byYDelta:verticalScrollPositionDelta];
    
    editorView.superview.frame = frame;
    editorView.frame = frame;
}

- (NSView *)snapshotOfView:(NSView *)view
{
    NSImage *image = [[NSImage alloc] initWithData:[view dataWithPDFInsideRect:view.bounds]];
    NSImageView *imageView = [[NSImageView alloc] initWithFrame:view.frame];
    imageView.image = image;
    return imageView;
}

- (void)adjustYScrollPositionInScrollView:(NSScrollView *)scrollView byYDelta:(CGFloat)value
{
    NSClipView *clipView = [scrollView contentView];
    
    NSPoint scrollPosition = [clipView documentVisibleRect].origin;
    
    scrollPosition.y += value;
    
    [clipView scrollToPoint:scrollPosition];
    [scrollView reflectScrolledClipView:clipView];
}

- (NSTextView *)textViewInEditor:(IDEEditor *)editor
{
    if ([editor isKindOfClass:NSClassFromString(@"IDESourceCodeEditor")]) {
        return [(IDESourceCodeEditor *)editor textView];
    }
    return nil;
}

- (ZENContainerView *)maskViewForSidebar:(DVTTextSidebarView *)sidebarView
{
    ZENContainerView *containerView = [[ZENContainerView alloc] initWithFrame:sidebarView.frame];
    containerView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    containerView.backgroundColor = self.backgroundColor;
    return containerView;
}

#pragma mark -

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

static inline NSString *ZENFrameKeypath()
{
    return NSStringFromSelector(@selector(frame));
}

static inline NSString *ZENWindowKeypath()
{
    return NSStringFromSelector(@selector(window));
}

@end
