//
//  WCEditorConfiguration.h
//  WCDistractionFreeXcodePlugin
//
//  Created by Wojciech Czekalski on 08.03.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCXcodeHeaders.h"

@protocol WCEditorConfiguration <NSObject>
@property (nonatomic, readonly) IDEWorkspace *workspace;
@property (nonatomic, readonly) IDEEditorOpenSpecifier *openSpecifier;
@property (nonatomic, readonly) IDEFileReferenceNavigableItem *greatestDocumentAncestor;
@property (nonatomic, readonly) IDEWorkspaceTabController *tabController;
@end

@interface WCEditorConfigurationBuilder : NSObject <WCEditorConfiguration>
@property (nonatomic) IDEFileReferenceNavigableItem *greatestDocumentAncestor;
@property (nonatomic) IDEWorkspaceTabController *tabController;
@end

@interface WCEditorConfiguration : NSObject <WCEditorConfiguration>
- (instancetype)initWithConfigurationBuilder:(void(^)(WCEditorConfigurationBuilder *configuration))builderBlock;
@end
