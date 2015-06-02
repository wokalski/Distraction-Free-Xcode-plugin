//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class DVTButtonTextField, NSButton, NSDictionary, NSObject<IBAutolayoutItem>, NSSet;

@interface IBAutolayoutConstraintAdditionTypeConfig : NSObject
{
    BOOL _shouldAdd;
    BOOL _enabled;
    DVTButtonTextField *_textField;
    NSButton *_checkBox;
    NSSet *_constraints;
    NSDictionary *_orderedNearestNeighborsToDistance;
    NSObject<IBAutolayoutItem> *_selectedNearestNeighbor;
    unsigned long long _nearestNeighborAttribute;
}

@property(nonatomic) unsigned long long nearestNeighborAttribute; // @synthesize nearestNeighborAttribute=_nearestNeighborAttribute;
@property(retain, nonatomic) NSObject<IBAutolayoutItem> *selectedNearestNeighbor; // @synthesize selectedNearestNeighbor=_selectedNearestNeighbor;
@property(retain, nonatomic) NSDictionary *orderedNearestNeighborsToDistance; // @synthesize orderedNearestNeighborsToDistance=_orderedNearestNeighborsToDistance;
@property(nonatomic) BOOL enabled; // @synthesize enabled=_enabled;
@property(nonatomic) BOOL shouldAdd; // @synthesize shouldAdd=_shouldAdd;
@property(copy, nonatomic) NSSet *constraints; // @synthesize constraints=_constraints;
@property(retain, nonatomic) NSButton *checkBox; // @synthesize checkBox=_checkBox;
@property(retain, nonatomic) DVTButtonTextField *textField; // @synthesize textField=_textField;
- (void).cxx_destruct;

@end
