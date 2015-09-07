//
//  ZENViewController.m
//  Zen
//
//  Created by Wojciech Czekalski on 15.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "ZENViewController.h"
#import "ZENContainerView.h"
#import "ZENMouseInteractionView.h"

@interface ZENViewController ()

@property (nonatomic, strong) NSLayoutConstraint *xPositionConstraint;
@property (nonatomic, strong) NSLayoutConstraint *yPositionConstraint;
@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *widthConstraint;

@end

@implementation ZENViewController

- (instancetype)initWithEditorViewController:(NSViewController *)editorViewController layout:(id<ZENEditorLayout>)layout backgroundColor:(NSColor *)backgroundColor interfaceController:(id<ZENInterfaceController>)interfaceController __attribute__((nonnull));
{
    NSParameterAssert(editorViewController);
    NSParameterAssert(layout);
    NSParameterAssert(backgroundColor);
    NSParameterAssert(interfaceController);
    
    self = [super init];
    
    if (self) {
        _editorViewController = editorViewController;
        _layout = layout;
        _backgroundColor = backgroundColor;
        _interfaceController = interfaceController;
    }

    return self;
}

- (void)loadView
{
    ZENMouseInteractionView *interactionView = [[ZENMouseInteractionView alloc] initWithInterfaceController:self.interfaceController];
    
    ZENContainerView *view = [[ZENContainerView alloc] init];
    view.backgroundColor = self.backgroundColor;
    view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    [interactionView addSubview:view];
    
    self.view = interactionView;
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addChildViewController:self.editorViewController];
    [self.view addSubview:self.editorViewController.view];
    
    self.editorViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.xPositionConstraint = [self viewToEditorConstraintForAttribute:NSLayoutAttributeLeading];
    self.yPositionConstraint = [self viewToEditorConstraintForAttribute:NSLayoutAttributeBottom];
    self.widthConstraint = [NSLayoutConstraint constraintWithItem:self.editorViewController.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0];
    self.heightConstraint = [self viewToEditorConstraintForAttribute:NSLayoutAttributeHeight];
    
    [self.view addConstraints:@[self.xPositionConstraint, self.yPositionConstraint, self.widthConstraint, self.heightConstraint]];
}

- (NSLayoutConstraint *)viewToEditorConstraintForAttribute:(NSLayoutAttribute)attribute
{
    return [NSLayoutConstraint constraintWithItem:self.view attribute:attribute relatedBy:NSLayoutRelationEqual toItem:self.editorViewController.view attribute:attribute multiplier:1 constant:0];
}

- (void)updateViewConstraints
{
    CGRect editorRect = [self.layout editorRectInBounds:self.view.bounds];
    
    self.xPositionConstraint.constant = -editorRect.origin.x;
    self.yPositionConstraint.constant = editorRect.origin.y;
    self.widthConstraint.constant = editorRect.size.width;
    
    [super updateViewConstraints];
}

@end
