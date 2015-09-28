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

@interface Zen() <NSWindowDelegate>

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@property (nonatomic, strong) NSMutableArray *windowControllers;

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
        self.windowControllers = [NSMutableArray new];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowWillClose:) name:NSWindowWillCloseNotification object:nil];
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
    NSString *version = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Distraction Free Mode" action:@selector(toggleDistractionFreeMode:) keyEquivalent:[self keyEquivalentForVersion:version]];
    [actionMenuItem setKeyEquivalentModifierMask:NSCommandKeyMask | NSControlKeyMask | NSShiftKeyMask];
    [actionMenuItem setTarget:self];
    return actionMenuItem;
}

- (NSString *)keyEquivalentForVersion:(NSString *)version
{
    if ([version isEqualToString:@"6.4"]) {
        return @"F";
    }
    return @"Z";
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem
{
    IDEWorkspaceWindowController *windowController = [IDEWorkspaceWindow lastActiveWorkspaceWindowController];
    
    menuItem.title = [self menuItemTitleForWindowController:windowController];
    DVTFilePath *filePath = [self documentFilePathInWindowController:windowController];
    
    if (filePath == nil) {
        return NO;
    }
    
    DVTFileDataType *dataType = [DVTFileDataType fileDataTypeForFilePath:filePath error:nil];
    
    return ZENFileDataTypeIsValid(dataType);
}

- (NSString *)menuItemTitleForWindowController:(NSWindowController *)windowController
{
    if ([self windowControllerIsZENController:windowController]) {
        return @"Close Distradction Free Mode";
    } else {
        return @"Distradction Free Mode";
    }
}

- (BOOL)windowControllerIsZENController:(NSWindowController *)controller
{
    return [controller isKindOfClass:[ZENWindowController class]];
}

- (DVTFilePath *)documentFilePathInWindowController:(IDEWorkspaceWindowController *)windowController
{
    return [[[[[[windowController activeWorkspaceTabController] editorArea] lastActiveEditorContext] editor] document] filePath];
}

- (void)toggleDistractionFreeMode:(id)sender
{
    NSWindowController *activeWindowController = [IDEWorkspaceWindow lastActiveWorkspaceWindowController];
    
    if ([self windowControllerIsZENController:activeWindowController]) {
        [activeWindowController close];
        [self.windowControllers removeObject:activeWindowController];
    } else {
        NSWindowController *windowController = [self makeWindowController];
        
        [windowController showWindow:self];
        [windowController.window setFrame:[[NSScreen mainScreen] frame] display:YES];
        [windowController.window toggleFullScreen:self];
        
        [self.windowControllers addObject:windowController];
    }
}

- (void)windowWillClose:(NSNotification *)notification
{
    for (NSWindowController *controller in self.windowControllers) {
        if (controller.window == notification.object) {
            [self.windowControllers removeObject:controller];
        }
    }
}

- (NSWindowController *)makeWindowController
{
    IDEWorkspaceWindowController *workspaceController = [IDEWorkspaceWindow lastActiveWorkspaceWindowController];
    
    ZENIDEEditorContextConfiguration *editorConfiguration = [[ZENIDEEditorContextConfiguration alloc] initWithIDEWorkspaceTabController:workspaceController.activeWorkspaceTabController];
    
    IDEEditorContext *editorContext = [[IDEEditorContext alloc] initWithNibName:NSStringFromClass([IDEEditorContext class]) bundle:[NSBundle bundleForClass:[IDEEditorContext class]]];
    
    ZENIDEEditorContextDependencyManager *dependencyManager = [[ZENIDEEditorContextDependencyManager alloc] initWithWorkspaceDocument:workspaceController.activeWorkspaceTabController.workspaceDocument editorContext:editorContext];
    
    ZENBarsController *barsController = [[ZENBarsController alloc] initWithEditorContext:editorContext backgroundColor:[[DVTFontAndColorTheme currentTheme] sourceTextBackgroundColor]];
    
    ZENEditorWrapperViewController *wrapperViewController = [[ZENEditorWrapperViewController alloc] initWithEditorContext:editorContext editorDependencyManager:dependencyManager barsController:barsController];
    
    ZENAndPeace *peace = [[ZENAndPeace alloc] initWithBarsController:barsController];
    
    ZENViewController *zenController = [[ZENViewController alloc] initWithEditorViewController:wrapperViewController layout:[ZENMinimalLayout new] backgroundColor:[[DVTFontAndColorTheme currentTheme] sourceTextBackgroundColor] interfaceController:peace];
    
    ZENWindow *window = [[ZENWindow alloc] initWithContentRect:zenController.view.frame styleMask:NSFullSizeContentViewWindowMask | NSClosableWindowMask backing:NSBackingStoreRetained defer:NO];
    window.releasedWhenClosed = YES;
    window.contentViewController = zenController;
    
    NSWindowController *windowController = [[ZENWindowController alloc] initWithWindow:window dependencyManager:dependencyManager];
    
    windowController.window.collectionBehavior = window.collectionBehavior | NSWindowCollectionBehaviorFullScreenPrimary;
    
    // ORDER IMPORTANT HERE! This method should be called when an IDEEditorContext is in a window. All dependencies are resolved then #XcodeArchitecture
    [editorContext openEditorOpenSpecifier:editorConfiguration.openSpecifier];
    
    return windowController;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
