//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class IDESourceCodeGenerationCompositeResult, IDESourceCodeGenerator, NSSet;

@protocol IDESourceCodeGenerationDestination <NSObject>
- (IDESourceCodeGenerationCompositeResult *)sourceCodeGenerator:(IDESourceCodeGenerator *)arg1 commitInsertionOfSourceCodeForCompositeResult:(IDESourceCodeGenerationCompositeResult *)arg2 error:(id *)arg3;
- (NSSet *)supportedSourceCodeLanguagesForSourceCodeGeneration;
@end
