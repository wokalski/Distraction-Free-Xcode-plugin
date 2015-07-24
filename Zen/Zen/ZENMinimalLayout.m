//
//  ZENMinimalLayout.m
//  Zen
//
//  Created by Wojciech Czekalski on 19.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "ZENMinimalLayout.h"

@implementation ZENMinimalLayout

- (CGRect)editorRectInBounds:(CGRect)bounds
{
    return CGRectInset(bounds, CGRectGetWidth(bounds)/5, 0);
}

@end
