//
//  IDEEditor+ZENTextView.m
//  Zen
//
//  Created by Wojciech Czekalski on 06.09.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "IDEEditor+ZENTextView.h"

@implementation IDEEditor (ZENTextView)

- (NSTextView *)zen_textView
{
    if ([self isKindOfClass:NSClassFromString(@"IDESourceCodeEditor")]) {
        return [(IDESourceCodeEditor *)self textView];
    }
    return nil;
}

@end
