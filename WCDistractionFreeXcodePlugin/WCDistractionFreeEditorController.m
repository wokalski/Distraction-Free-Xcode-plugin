//
//  WCDistractionFreeViewController.m
//  WCDistractionFreeXcodePlugin
//
//  Created by Wojciech Czekalski on 08.01.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "WCDistractionFreeEditorController.h"
#import "WCXcodeHeaders.h"
#import "WCEditorConfiguration.h"
#import "WCContainerView.h"
#import <objc/objc-runtime.h>

@interface WCDistractionFreeEditorController () <IDEEditorContextDelegate>
@property (nonatomic, strong) NSView *containerView;
@property (nonatomic, strong) NSLayoutConstraint *leftSideConstraint;
@property (nonatomic, strong) NSLayoutConstraint *rightSideConstraint;
@property (nonatomic, strong) IDEEditorContext *editorContext;
@end

@implementation WCDistractionFreeEditorController

- (BOOL)isKindOfClass:(Class)aClass
{
    if ([self resolvingWorkspaceTabController]) {
        self.editorContext.editor.workspaceTabController = self.configuration.tabController;
    }
    return [super isKindOfClass:aClass];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.containerView = ({
        NSView *containerView = [[WCContainerView alloc] initWithViewController:self];
        containerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:containerView];
        
        NSLayoutConstraint * (^constraintForContainerViewWithAttribute)(NSLayoutAttribute attribute) = ^NSLayoutConstraint *(NSLayoutAttribute attribute){
            return [NSLayoutConstraint constraintWithItem:containerView attribute:attribute relatedBy:NSLayoutRelationEqual toItem:self.view attribute:attribute multiplier:1.f constant:0.f];
        };
        
        self.leftSideConstraint = constraintForContainerViewWithAttribute(NSLayoutAttributeLeft);
        self.rightSideConstraint = constraintForContainerViewWithAttribute(NSLayoutAttributeRight);
        
        self.leftSideConstraint.constant = 300;
        self.rightSideConstraint.constant = -300;
        
        [self.view addConstraint:constraintForContainerViewWithAttribute(NSLayoutAttributeTop)];
        [self.view addConstraint:constraintForContainerViewWithAttribute(NSLayoutAttributeBottom)];
        [self.view addConstraints:@[self.leftSideConstraint, self.rightSideConstraint]];
        
        containerView;
    });
    
    self.editorContext = [[NSClassFromString(@"IDEEditorContext") alloc] initWithNibName:NSStringFromClass([NSClassFromString(@"IDEEditorContext") class]) bundle:[NSBundle bundleForClass:[NSClassFromString(@"IDEEditorContext") class]]];
    
    self.editorContext.delegate = self;
    
    [self updateContentViewWithEditorContext:self.editorContext];
}

- (void)viewWillDisappear
{
    [super viewWillDisappear];
}

- (void)updateContentViewWithEditorContext:(IDEEditorContext *)sourceCodeEditor
{
    if (self.containerView && sourceCodeEditor) {
        [self addChildViewController:sourceCodeEditor];
        [self.containerView addSubview:sourceCodeEditor.view];
        sourceCodeEditor.view.frame = NSMakeRect(0, 0, 300, 300);
        sourceCodeEditor.view.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint * (^constraintForEditorViewWithAttribute)(NSLayoutAttribute attribute) = ^NSLayoutConstraint *(NSLayoutAttribute attribute){
            return [NSLayoutConstraint constraintWithItem:sourceCodeEditor.view attribute:attribute relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:attribute multiplier:1.f constant:0.f];
        };

        [self.containerView addConstraint:constraintForEditorViewWithAttribute(NSLayoutAttributeLeft)];
        [self.containerView addConstraint:constraintForEditorViewWithAttribute(NSLayoutAttributeRight)];
        [self.containerView addConstraint:constraintForEditorViewWithAttribute(NSLayoutAttributeBottom)];
        [self.containerView addConstraint:constraintForEditorViewWithAttribute(NSLayoutAttributeTop)];
    }
    [self.containerView layout];
}

- (id)workspaceForEditorContext:(id)arg1
{
    return self.workspace;
}

- (void)editorContext:(IDEEditorContext *)arg1 didSetNavigableItem:(IDENavigableItem *)arg2
{
    self.editorContext.editor.workspaceTabController = self.configuration.tabController;
}

- (void)setConfiguration:(WCEditorConfiguration *)configuration
{
    if (_configuration != configuration) {
        _configuration = configuration;
        
        self.editorContext.greatestDocumentAncestor = configuration.greatestDocumentAncestor;
        self.editorContext.workspaceTabController = configuration.tabController;
        
        if (![self.editorContext openEditorOpenSpecifier:configuration.openSpecifier]) {
            NSLog(@"Could not open file with open specifier: %@", configuration.openSpecifier);
        } else {
            // inspect editor
            self.editorContext.editor.workspaceTabController = configuration.tabController;
        }
    }
}

- (IDEWorkspace *)workspace
{
    return self.configuration.workspace;
}

# pragma mark IDEWorkspaceTabController

- (IDEWorkspaceDocument *)workspaceDocument
{
    return self.configuration.tabController.workspaceDocument;
}

- (BOOL)isValid
{
    return [self resolvingWorkspaceTabController];
}

- (id)invalidationBacktrace
{
    return self.configuration.tabController.workspaceDocument;
}

- (BOOL)resolvingWorkspaceTabController
{
    NSArray *stackSymbols = [NSThread callStackSymbols];
    
    for (NSInteger i = 0; i < stackSymbols.count; i++) {
        if ([self resolveInTheCallStack:stackSymbols[i]]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)resolveInTheCallStack:(NSString *)stack
{
    return ([stack rangeOfString:@"resolveWorkspaceTabController"].location != NSNotFound) ||
            ([stack rangeOfString:@"initWithWorkspaceTabController"].location != NSNotFound);
}

@end
