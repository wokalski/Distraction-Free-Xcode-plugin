//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <GPUDebuggerFoundation/GPUTraceResourceItem.h>

@class GPUTraceShaderItem;

@interface GPUTraceProgramItem : GPUTraceResourceItem
{
    BOOL _pipeline;
    GPUTraceShaderItem *_defaultShaderItem;
}

@property(readonly, nonatomic, getter=isPipeline) BOOL pipeline; // @synthesize pipeline=_pipeline;
@property(nonatomic) GPUTraceShaderItem *defaultShaderItem; // @synthesize defaultShaderItem=_defaultShaderItem;
- (void)primitiveInvalidate;
- (id)initProgramWithController:(id)arg1 parent:(id)arg2 programID:(unsigned long long)arg3 isPipeline:(BOOL)arg4 unrealizedResourceObject:(const void *)arg5 containerID:(unsigned long long)arg6 sharegroupID:(unsigned long long)arg7 label:(id)arg8;
- (id)initComputePipelineStateWithController:(id)arg1 parent:(id)arg2 programID:(unsigned long long)arg3 unrealizedResourceObject:(const void *)arg4 containerID:(unsigned long long)arg5 label:(id)arg6;
- (id)initRenderPipelineStateWithController:(id)arg1 parent:(id)arg2 programID:(unsigned long long)arg3 unrealizedResourceObject:(const void *)arg4 containerID:(unsigned long long)arg5 label:(id)arg6;
- (id)_initWithController:(id)arg1 parent:(id)arg2 programID:(unsigned long long)arg3 unrealizedResourceObject:(const void *)arg4 containerID:(unsigned long long)arg5 sharegroupID:(unsigned long long)arg6 label:(id)arg7 type:(unsigned int)arg8;
- (void)establishChildren;

@end

