//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <IBAutolayoutFoundation/IBContentSizeLayoutConstraintAbstractionRepresentation.h>

@interface IBContentHuggingLayoutConstraintAbstractionRepresentation : IBContentSizeLayoutConstraintAbstractionRepresentation
{
    double _huggingPriority;
}

@property(nonatomic) double huggingPriority; // @synthesize huggingPriority=_huggingPriority;
- (void)encodeWithBinaryArchiver:(id)arg1;
- (void)encodeWithCoder:(id)arg1;
- (id)initWithBinaryUnarchiver:(id)arg1;
- (id)initWithCoder:(id)arg1;
- (Class)abstractionClass;
- (id)abstractionWithLayoutConstraintClass:(Class)arg1 objectForObjectRepresentationBlock:(CDUnknownBlockType)arg2;

@end
