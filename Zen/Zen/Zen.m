//
//  Zen.m
//  Zen
//
//  Created by Wojciech Czekalski on 15.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "Zen.h"
#import "ZENViewController.h"
#import "ZENMinimalLayout.h"
#import "ZENContainerView.h"
#import "ZENWindowController.h"
#import "XcodeHeaders.h"
#import "ZENIDEEditorContextConfiguration.h"
#import "ZENEditorWrapperViewController.h"
#import "ZENIDEEditorContextDependencyManager.h"
#import "ZENWindow.h"
#import "ZENBarsController.h"
#import "ZENAndPeace.h"

static Zen *sharedPlugin;

@interface Zen()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@property (nonatomic, strong) NSWindowController *windowController;

@end

@implementation Zen

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[Zen alloc] initWithBundle:plugin];
        });
    }
}

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    //removeObserver
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    // Create menu items, initialize UI, etc.
    // Sample Menu Item:
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"View"];
    if (menuItem) {
        [[menuItem submenu] addItem:[self ZEN_menuItem]];
    }
}

- (NSMenuItem *)ZEN_menuItem
{
    NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Distraction Free Mode" action:@selector(launch:) keyEquivalent:@"F"];
    [actionMenuItem setKeyEquivalentModifierMask:NSCommandKeyMask | NSControlKeyMask | NSShiftKeyMask];
    [actionMenuItem setTarget:self];
    return actionMenuItem;
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem
{
    IDEWorkspaceWindowController *workspaceController = [IDEWorkspaceWindow lastActiveWorkspaceWindowController];
    Class editorClass = [[[[[workspaceController activeWorkspaceTabController] editorArea] lastActiveEditorContext] editor] class];
    return [editorClass isSubclassOfClass:NSClassFromString(@"IDESourceCodeEditor")];
}

- (void)launch:(id)sender
{
    self.windowController = [self makeWindowController];
    
    NSRect rect = [[NSScreen mainScreen] frame];
    
    [self.windowController.window setFrame:rect display:YES];
    [self.windowController.window toggleFullScreen:nil];
    [self.windowController showWindow:self];
}

- (NSWindowController *)makeWindowController
{
    IDEWorkspaceWindowController *workspaceController = [IDEWorkspaceWindow lastActiveWorkspaceWindowController];
    
    ZENIDEEditorContextConfiguration *editorConfiguration = [[ZENIDEEditorContextConfiguration alloc] initWithIDEWorkspaceTabController:workspaceController.activeWorkspaceTabController];
    
    IDEEditorContext *editorContext = [[IDEEditorContext alloc] initWithNibName:NSStringFromClass([IDEEditorContext class]) bundle:[NSBundle bundleForClass:[IDEEditorContext class]]];
    
    ZENIDEEditorContextDependencyManager *dependencyManager = [[ZENIDEEditorContextDependencyManager alloc] initWithWorkspaceDocument:workspaceController.activeWorkspaceTabController.workspaceDocument editorContext:editorContext];
    
    ZENEditorWrapperViewController *wrapperViewController = [[ZENEditorWrapperViewController alloc] initWithEditorContext:editorContext editorDependencyManager:dependencyManager];
    
    ZENBarsController *barsController = [[ZENBarsController alloc] initWithEditorContext:editorContext backgroundColor:[[DVTFontAndColorTheme currentTheme] sourceTextBackgroundColor]];
    
    ZENAndPeace *peace = [[ZENAndPeace alloc] initWithBarsController:barsController];
    
    ZENViewController *zenController = [[ZENViewController alloc] initWithEditorViewController:wrapperViewController layout:[ZENMinimalLayout new] backgroundColor:[[DVTFontAndColorTheme currentTheme] sourceTextBackgroundColor] interfaceController:peace];
    
    ZENWindow *window = [[ZENWindow alloc] initWithContentRect:zenController.view.frame styleMask:NSFullSizeContentViewWindowMask | NSClosableWindowMask backing:NSBackingStoreRetained defer:NO];
    window.releasedWhenClosed = YES;
    window.contentViewController = zenController;
    [zenController.view layoutSubtreeIfNeeded];
    
    NSWindowController *windowController = [[ZENWindowController alloc] initWithWindow:window dependencyManager:dependencyManager];
    
    windowController.window.collectionBehavior = NSWindowCollectionBehaviorFullScreenPrimary;
    
    // ORDER IMPORTANT HERE! This method should be called when an IDEEditorContext is in a window. All dependencies are resolved then #XcodeArchitecture
    [editorContext openEditorOpenSpecifier:editorConfiguration.openSpecifier];
    
// FIXME: This call should belong to appearance specific section of the code. Due to many upcoming changes in the appearance it's going to be moved somewhere else.
    [[[barsController textViewInEditor:editorContext.editor] enclosingScrollView] setScrollerStyle:NSScrollerStyleOverlay];

    return windowController;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
