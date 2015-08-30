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
    CGFloat inset = CGRectGetWidth(bounds)/5;
    
    bounds.size.width -= inset * 2;
    bounds.origin.x += inset;
    
    return bounds;
}

@end
