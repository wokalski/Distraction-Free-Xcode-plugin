//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSString;

@interface IDEXcodeServerLegacyBot : NSObject
{
    NSString *_botName;
    NSString *_botGUID;
    NSString *_serverAddress;
    NSString *_serverName;
}

@property(copy, nonatomic) NSString *serverName; // @synthesize serverName=_serverName;
@property(copy, nonatomic) NSString *serverAddress; // @synthesize serverAddress=_serverAddress;
@property(copy, nonatomic) NSString *botGUID; // @synthesize botGUID=_botGUID;
@property(copy, nonatomic) NSString *botName; // @synthesize botName=_botName;
- (void).cxx_destruct;
- (id)initWithBotName:(id)arg1 botGUID:(id)arg2 serverAddress:(id)arg3 serverName:(id)arg4;

@end

