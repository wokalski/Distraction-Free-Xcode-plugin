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
#import "IDEEditor+ZENTextView.h"
@import ObjectiveC;

@implementation IDEEditorContext (ZENNavBar)
@dynamic navBar;
@dynamic sidebarView;
@end

@interface ZENBarsController ()
@property (nonatomic, strong) ZENContainerView *maskView;
@property (nonatomic, assign) BOOL barsShouldBeHidden;
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

#pragma mark -

- (void)layout
{
    if (self.barsShouldBeHidden) {
        [self hideBarsWithAnimation:nil];
    } else {
        [self showBarsWithAnimation:nil];
    }
}

- (void)hideBars
{
    [self hideBarsWithAnimation:[self hideBarsAnimation]];
}

- (void)showBars
{
    [self showBarsWithAnimation:[self showBarsAnimation]];
}

#pragma mark -

- (void)hideBarsWithAnimation:(void (^) (NSView *navBar, NSView *sidebarMaskView))hideBarsAnimation
{
    self.barsShouldBeHidden = YES;
    
    DVTTextSidebarView *sidebarView = self.editorContext.sidebarView;
    
    if (sidebarView) {
        [sidebarView addObserver:self forKeyPath:ZENFrameKeypath() options:0 context:NULL];
        [sidebarView addObserver:self forKeyPath:ZENWindowKeypath() options:0 context:NULL];
        
        [self.maskView removeFromSuperview];
        ZENContainerView *maskView = [self maskViewForSidebar:sidebarView];
        maskView.frame = sidebarView.frame;
        [sidebarView.superview addSubview:maskView];
        self.maskView = maskView;
    }
    
    [self adjustEditorToFrame:self.editorContext.view.frame];
    
    if (hideBarsAnimation) {
        hideBarsAnimation(self.editorContext.navBar, self.maskView);
    }
    
    self.editorContext.navBar.hidden = YES;

}

- (void (^)(NSView *, NSView *))hideBarsAnimation
{
    if (self.editorContext.navBar.window.screen == nil) {
        return nil;
    }
    
    return ^(NSView *navBar, NSView *maskView) {
       
        NSView *snapshotView = [self snapshotOfView:navBar];
        [self.editorContext.navBar.superview addSubview:snapshotView];
        
        maskView.alphaValue = 0.f;
        
        [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
            context.duration = .3;
            snapshotView.animator.alphaValue = 0;
            maskView.animator.alphaValue = 1;
        } completionHandler:^{
            [snapshotView removeFromSuperview];
        }];
    };
}

- (void (^)(NSView *, NSView *, void (^)()))showBarsAnimation
{
    return ^(NSView *navBar, NSView *maskView, void (^completionHandler)()) {
        
        NSView *snapshotView = [self snapshotOfView:navBar];
        
        [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
            context.duration = 0.3;
            [maskView.animator removeFromSuperview];
            [self.editorContext.view.superview.animator addSubview:snapshotView];
            
        } completionHandler:completionHandler];
    };
}

- (void)showBarsWithAnimation:(void (^) (NSView *navBar, NSView *sidebarMaskView, void (^completion)(void)))hideBarsAnimation
{
    self.barsShouldBeHidden = NO;
    
    IDENavBar *navBar = self.editorContext.navBar;
    
    void (^completion)() = ^{
        [self.maskView removeFromSuperview];
        self.maskView = nil;
        [self adjustEditorToFrame:[self editorFrameForShownBars]];
        navBar.hidden = NO;
    };
    
    if (navBar.hidden == YES) {
        
        if (hideBarsAnimation) {
            hideBarsAnimation(navBar, self.maskView, completion);
        } else {
            completion();
        }
    }
}

- (CGRect)editorFrameForShownBars
{
    CGFloat navBarHeight = self.editorContext.navBar.frame.size.height;
    CGRect editorBounds = self.editorContext.view.frame;
    editorBounds.size.height -= navBarHeight;
    return editorBounds;
}

#pragma mark -

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

- (void)adjustEditorToFrame:(CGRect)frame
{
    NSView *editorView = self.editorContext.editor.view;
    NSTextView *textView = [self.editorContext.editor zen_textView];
    
    CGFloat verticalScrollPositionDelta = -(CGRectGetHeight(frame) - CGRectGetHeight(editorView.frame));
    
    [self adjustYScrollPositionInScrollView:textView.enclosingScrollView byYDelta:verticalScrollPositionDelta];
    
    editorView.superview.frame = frame;
    editorView.frame = frame;
}

- (NSView *)snapshotOfView:(NSView *)view
{
    if (view.hidden == YES || view.alphaValue == 0) {
        return nil;
    }
    
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

- (ZENContainerView *)maskViewForSidebar:(DVTTextSidebarView *)sidebarView
{
    if (sidebarView == nil) {
        return nil;
    }
    
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
        if (ZENIsValidEditor(self.editor)) {
            return [[self editor] valueForKey:@"_sidebarView"];
        }
        return nil;
    });
}

BOOL ZENIsValidEditor(IDEEditor *editor) {
    return [editor isKindOfClass:NSClassFromString(@"IDESourceCodeEditor")];
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
