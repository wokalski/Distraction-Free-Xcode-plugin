//
//  WCDistractionFreeViewController.m
//  WCDistractionFreeXcodePlugin
//
//  Created by Wojciech Czekalski on 08.01.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "WCDistractionFreeViewController.h"
#import "WCXcodeHeaders.h"
#import "Aspects.h"

@interface WCDistractionFreeViewController ()
@property (nonatomic, strong) NSView *containerView;
@property (nonatomic, strong) NSLayoutConstraint *leftSideConstraint;
@property (nonatomic, strong) NSLayoutConstraint *rightSideConstraint;
@property (nonatomic, strong) IDESourceCodeEditor *sourceCodeEditorController;
@end

@implementation WCDistractionFreeViewController

- (void)setSourceCodeDocument:(IDESourceCodeDocument *)sourceCodeDocument
{
    if (sourceCodeDocument != _sourceCodeDocument) {
        _sourceCodeDocument = sourceCodeDocument;
        [self setSourceCodeEditorControllerWithDocument:sourceCodeDocument];
    }
}

- (void)setSourceCodeEditorControllerWithDocument:(IDESourceCodeDocument *)document
{
    self.sourceCodeEditorController = ({
        IDESourceCodeEditor *editor = [[NSClassFromString(@"IDESourceCodeEditor") alloc] initWithNibName:nil bundle:[NSBundle mainBundle] document:document];
        editor.workspaceTabController = self.tabController;
        editor.fileTextSettings = self.textSettings;

        IDEEditorContext *editorContext = [[NSClassFromString(@"IDEEditorContext") alloc] initWithNibName:NSStringFromClass([NSClassFromString(@"IDEEditorContext") class]) bundle:[NSBundle bundleForClass:[NSClassFromString(@"IDEEditorContext") class]]];
        editor.editorContext = editorContext;
        [editorContext setupNewEditor:editor];
        
        
        [self updateContentViewWithSourceCodeEditor:editor];
        editor;
    });
    
}

- (void)setTextSettings:(IDEFileTextSettings *)textSettings
{
    if (_textSettings != textSettings) {
        _textSettings = textSettings;
        self.sourceCodeEditorController.fileTextSettings = textSettings;
    }
}

- (void)setTabController:(IDEWorkspaceTabController *)tabController
{
    if (_tabController != tabController) {
        _tabController = tabController;
        self.sourceCodeEditorController.workspaceTabController = tabController;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.containerView = ({
        NSView *containerView = [[NSView alloc] init];
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
    
    [self updateContentViewWithSourceCodeEditor:self.sourceCodeEditorController];
}

- (void)updateContentViewWithSourceCodeEditor:(IDESourceCodeEditor *)sourceCodeEditor
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

- (void)mouseUp:(NSEvent *)theEvent
{
    [super mouseUp:theEvent];
}

@end
