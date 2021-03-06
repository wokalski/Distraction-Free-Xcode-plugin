//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "IDEKeyDrivenNavigableItem.h"

@class GPUTraceDocumentLocation, NSArray;

__attribute__((visibility("hidden")))
@interface GPUTraceProgramGroupNavigableItem : IDEKeyDrivenNavigableItem
{
    NSArray *_cachedChildRepresentedObjects;
    GPUTraceDocumentLocation *_cachedLocation;
    BOOL _displayRelatedDisplayables;
}

- (void).cxx_destruct;
- (BOOL)displayRelatedDisplayables:(BOOL)arg1;
- (void)invalidateChildItems;
- (id)childRepresentedObjects;
- (id)contentDocumentLocation;
- (id)name;
- (id)image;
- (id)documentType;
- (id)ideModelObjectTypeIdentifier;
- (id)initWithRepresentedObject:(id)arg1;

@end

