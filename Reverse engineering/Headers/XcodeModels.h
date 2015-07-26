//
//  WCXcodeModels.h
//  WCDistractionFreeXcodePlugin
//
//  Created by Wojciech Czekalski on 08.03.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DVTDocumentLocation : NSObject
- (DVTDocumentLocation *)initWithDocumentURL:(NSURL *)documentURL timestamp:(NSNumber *)timestamp;
- (NSURL *)documentURL;
@end

@interface DVTFilePath : NSObject
@property(readonly) NSURL *fileURL;
@end

@interface DVTModelObject : NSObject
@end

@interface IDEContainer : DVTModelObject
@end

@interface IDEXMLPackageContainer : IDEContainer
@end

@interface IDEWorkspace : IDEXMLPackageContainer
- (NSString *)name;
- (NSSet *)referencedContainers;
@end

@interface IDEWorkspaceDocument : NSDocument
@property(readonly) IDEWorkspace *workspace;
@end

@interface IDEContainerItem : DVTModelObject
@end

@interface IDEFileReference : IDEContainerItem
@property(readonly) DVTFilePath *resolvedFilePath;
@end

@interface IDENavigableItem : NSObject
@property (readonly) IDEFileReference *fileReference;
@end

@interface IDEFileNavigableItem : IDENavigableItem
@end

@interface IDEFileReferenceNavigableItem : IDEFileNavigableItem
@property (nonatomic, readonly) NSURL *fileURL;
- (instancetype)initWithRepresentedObject:(IDEFileReference *)fileReference;
@end

@interface IDENavigableItemArchivableRepresentation : NSObject
@end

@interface IDEEditorOpenSpecifier : NSObject
+ (instancetype)structureEditorOpenSpecifierForDocumentLocation:(DVTDocumentLocation *)documentLocation inWorkspace:(IDEWorkspace *)workspace error:(NSError **)error;
- (instancetype)initWithNavigableItem:(IDENavigableItem *)navigableItem error:(NSError **)error;
// debugging
@property(readonly) IDENavigableItemArchivableRepresentation *navigableItemRepresentation;
@end

@interface DVTTextStorage : NSTextStorage
@property(getter=isSyntaxColoringEnabled) BOOL syntaxColoringEnabled;
@end

@interface IDEFileTextSettings : NSObject
@end

@interface IDEEditorDocument : NSDocument
@end

@protocol IDEWorkspaceDocumentProvider <NSObject>
@property(readonly) IDEWorkspaceDocument *workspaceDocument;
@end

@interface DVTFontAndColorTheme : NSObject

@property(readonly) NSColor *sourceTextBackgroundColor;

+ (id)currentTheme;

@end
