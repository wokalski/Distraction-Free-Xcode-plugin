//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSMutableArray, NSMutableDictionary;

@interface XCSFormData : NSObject
{
    NSMutableArray *_fieldOrder;
    NSMutableDictionary *_fieldValues;
}

+ (id)multipartDataWithFileAtPath:(id)arg1 contentType:(id)arg2 boundary:(id *)arg3;
- (void).cxx_destruct;
- (id)renderMultipartData:(id *)arg1;
- (void)addFileWithFieldName:(id)arg1 path:(id)arg2 contentType:(id)arg3;
- (void)addFormFieldWithName:(id)arg1 value:(id)arg2;
- (id)init;

@end

