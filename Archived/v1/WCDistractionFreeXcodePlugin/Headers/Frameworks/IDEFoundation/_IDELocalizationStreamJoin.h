//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <IDEFoundation/IDELocalizationStream.h>

@interface _IDELocalizationStreamJoin : IDELocalizationStream
{
    id <IDELocalizationStreamPublisher> _publisher;
    id <IDELocalizationStreamPublisher> _joined;
}

+ (id)withPublisher:(id)arg1;
@property(retain) id <IDELocalizationStreamPublisher> joined; // @synthesize joined=_joined;
@property(retain) id <IDELocalizationStreamPublisher> publisher; // @synthesize publisher=_publisher;
- (void).cxx_destruct;
- (void)onCompleted;
- (void)onError:(id)arg1;
- (void)onNext:(id)arg1;
- (id)subscribe:(id)arg1;

@end

