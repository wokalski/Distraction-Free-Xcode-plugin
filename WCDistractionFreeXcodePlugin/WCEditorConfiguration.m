//
//  WCEditorConfiguration.m
//  WCDistractionFreeXcodePlugin
//
//  Created by Wojciech Czekalski on 08.03.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "WCEditorConfiguration.h"

@interface WCEditorConfiguration ()
@property (nonatomic) IDEWorkspace *workspace;
@property (nonatomic) IDEEditorOpenSpecifier *openSpecifier;
@property (nonatomic) IDEFileReferenceNavigableItem *greatestDocumentAncestor;
@property (nonatomic) IDEWorkspaceTabController *tabController;
@end

@implementation WCEditorConfiguration

- (instancetype)initWithConfigurationBuilder:(void (^)(WCEditorConfigurationBuilder *))builderBlock
{
    NSParameterAssert(builderBlock);
    self = [super init];
    if (self) {
        WCEditorConfigurationBuilder __block *builder = [WCEditorConfigurationBuilder new];
        builderBlock(builder);
        
        self.workspace = builder.workspace;
        self.openSpecifier = builder.openSpecifier;
        self.greatestDocumentAncestor = builder.greatestDocumentAncestor;
        self.tabController = builder.tabController;
    }
    return self;
}

@end

static Class IDEEditorOpenSpecifierClass()
{
    return NSClassFromString(@"IDEEditorOpenSpecifier");
}

@implementation WCEditorConfigurationBuilder

- (IDEEditorOpenSpecifier *)openSpecifier
{
    NSParameterAssert(self.workspace);
    NSParameterAssert(self.fileURL);
    
    DVTDocumentLocation *location = [[NSClassFromString(@"DVTDocumentLocation") alloc] initWithDocumentURL:self.fileURL timestamp:nil];
    
    NSError *error;
    
    IDEEditorOpenSpecifier *openSpecifier = [IDEEditorOpenSpecifierClass() structureEditorOpenSpecifierForDocumentLocation:location inWorkspace:self.workspace error:&error];
    
    if (error) {
        NSLog(@"WCDistractionFreePlugin: Unexpected error:\n%@", error);
    }
    
    return openSpecifier;
}

- (NSURL *)fileURL
{
    return self.greatestDocumentAncestor.fileURL;
}

- (IDEWorkspace *)workspace
{
    return self.tabController.workspaceDocument.workspace;
}

@end