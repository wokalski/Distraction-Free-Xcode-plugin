//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSView;

@interface IBViewRenderer : NSObject
{
    NSView *view;
    id <IBRenderingDestination> destination;
}

+ (id)rendererWithView:(id)arg1 renderingDestination:(id)arg2;
@property(readonly, nonatomic) id <IBRenderingDestination> destination; // @synthesize destination;
@property(readonly, nonatomic) NSView *view; // @synthesize view;
- (void).cxx_destruct;
- (void)renderIntoCoreGraphicsContext:(id)arg1;
- (id)renderViewImage;
- (id)renderContent;
- (void)invokeWithDestinationScaleFactors:(CDUnknownBlockType)arg1;
- (id)initWithView:(id)arg1 renderingDestination:(id)arg2;

@end
