//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <DTDeviceKitBase/DTDKApplicationFileBase.h>

@interface DTDKApplicationFile : DTDKApplicationFileBase
{
}

+ (id)itemWithName:(id)arg1 andParent:(id)arg2 fromStream:(id)arg3 error:(id *)arg4;
+ (id)itemWithParent:(id)arg1 fromLocalFile:(id)arg2 error:(id *)arg3;
- (_Bool)isLeaf;
- (id)sandboxFileBases;
- (_Bool)downloadOptimizationProfilesToFile:(id)arg1 error:(id *)arg2;
- (_Bool)downloadToFile:(id)arg1 error:(id *)arg2;

@end
