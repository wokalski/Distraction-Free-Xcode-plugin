//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSString, XCSIntegration, XCSIntegrationIssue;

@interface XCSUIIntegrationIssue : NSObject
{
    unsigned long long _issueUIType;
    XCSIntegrationIssue *_issue;
    XCSIntegration *_integration;
}

+ (id)colorForUIIssueType:(unsigned long long)arg1;
+ (id)issueTypeStringFromUIIssueType:(unsigned long long)arg1;
@property(readonly) XCSIntegration *integration; // @synthesize integration=_integration;
@property(readonly) XCSIntegrationIssue *issue; // @synthesize issue=_issue;
@property(readonly) unsigned long long issueUIType; // @synthesize issueUIType=_issueUIType;
- (void).cxx_destruct;
@property(readonly, copy) NSString *stringRepresentation;
@property(readonly, copy) NSString *briefStringRepresentation;
- (id)initWithIntegrationIssue:(id)arg1 type:(unsigned long long)arg2 integration:(id)arg3;

@end

