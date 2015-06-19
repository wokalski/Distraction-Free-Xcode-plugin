//
//  ZENViewController.m
//  Zen
//
//  Created by Wojciech Czekalski on 15.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "ZENViewController.h"
#import "ZENContainerView.h"

@implementation ZENViewController

- (instancetype)initWithEditorViewController:(NSViewController *)editorViewController layout:(id<ZENEditorLayout>)layout
{
    self = [super init];
    
    if (self) {
        _editorViewController = editorViewController;
        _layout = layout;
    }

    return self;
}

- (void)loadView
{
    ZENContainerView *view = [[ZENContainerView alloc] init];
    view.backgroundColor = [NSColor blueColor];
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.editorViewController.view];
}

- (void)viewWillLayout
{
    [super viewWillLayout];
    
    [self performLayout];
}

- (void)performLayout
{
    self.editorViewController.view.frame = [self.layout editorRectInBounds:self.view.bounds];
}
    
@end
