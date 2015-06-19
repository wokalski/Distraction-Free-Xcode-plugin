//
//  Zen.m
//  Zen
//
//  Created by Wojciech Czekalski on 15.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "Zen.h"
#import "ZENViewController.h"
#import "ZENStupidLayout.h"
#import "ZENContainerView.h"
#import "ZENWindowController.h"

@interface Zen()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@property (nonatomic, strong) NSWindowController *windowController;

@end

@implementation Zen

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
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        [[menuItem submenu] addItem:[self ZEN_menuItem]];
    }
}

- (NSMenuItem *)ZEN_menuItem
{
    NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"GO ZEN" action:@selector(launch:) keyEquivalent:@""];
    [actionMenuItem setTarget:self];
    return actionMenuItem;
}

- (void)launch:(id)sender
{
    NSViewController *viewController = [[NSViewController alloc] init];
    
    NSTextView *textView = [[NSTextView alloc] initWithFrame:NSZeroRect];
    
    viewController.view = textView;
    
    ZENViewController *zenController = [[ZENViewController alloc] initWithEditorViewController:viewController layout:[ZENStupidLayout new]];
    
    NSWindowController *windowController = [[ZENWindowController alloc] initWithWindow:[NSWindow windowWithContentViewController:zenController]];
    
    [windowController.window setFrame:NSMakeRect(0, 0, 500, 500) display:NO];
    [windowController showWindow:self];
    
    self.windowController = windowController;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
